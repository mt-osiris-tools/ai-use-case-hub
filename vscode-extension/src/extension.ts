import * as vscode from 'vscode';
import * as cp from 'child_process';
import * as path from 'path';
import * as os from 'os';
import * as fs from 'fs';

export function activate(context: vscode.ExtensionContext) {
    console.log('AI Session Documentor extension is now active');

    // Register all commands
    const commands = [
        { id: 'aiSessionDocumentor.documentSession', handler: documentAISession },
        { id: 'aiSessionDocumentor.setupProject', handler: setupProject },
        { id: 'aiSessionDocumentor.syncUseCases', handler: syncUseCases },
        { id: 'aiSessionDocumentor.searchUseCases', handler: searchUseCases },
        { id: 'aiSessionDocumentor.viewInHub', handler: viewInHub }
    ];

    commands.forEach(({ id, handler }) => {
        const command = vscode.commands.registerCommand(id, async () => {
            try {
                await handler();
            } catch (error) {
                vscode.window.showErrorMessage(
                    `Command failed: ${error instanceof Error ? error.message : String(error)}`
                );
            }
        });
        context.subscriptions.push(command);
    });
}

async function documentAISession() {
    const config = vscode.workspace.getConfiguration('aiSessionDocumentor');

    if (!config.get('enabled', true)) {
        vscode.window.showInformationMessage('AI Session Documentor is disabled');
        return;
    }

    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    if (!workspaceFolder) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const projectPath = workspaceFolder.uri.fsPath;
    const scriptPath = getScriptPath(config, 'document-ai-session.sh');

    await vscode.window.withProgress(
        {
            location: vscode.ProgressLocation.Notification,
            title: 'Documenting AI Session',
            cancellable: false
        },
        async (progress) => {
            progress.report({ message: 'Launching interactive session...' });

            if (!fs.existsSync(scriptPath)) {
                throw new Error(`Script not found: ${scriptPath}`);
            }

            const terminal = vscode.window.createTerminal({
                name: 'AI Session Documentor',
                cwd: projectPath
            });

            terminal.show();
            terminal.sendText(`bash "${scriptPath}" "${projectPath}"`);
            await new Promise(resolve => setTimeout(resolve, 500));

            vscode.window.showInformationMessage(
                'Follow the prompts in the terminal to document your AI session'
            );
        }
    );
}

async function setupProject() {
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    if (!workspaceFolder) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const config = vscode.workspace.getConfiguration('aiSessionDocumentor');
    const projectPath = workspaceFolder.uri.fsPath;
    const scriptPath = getScriptPath(config, 'setup-project.sh');

    if (!fs.existsSync(scriptPath)) {
        throw new Error(`Setup script not found: ${scriptPath}`);
    }

    const terminal = vscode.window.createTerminal({
        name: 'Setup AI Use Cases',
        cwd: projectPath
    });

    terminal.show();
    terminal.sendText(`bash "${scriptPath}" "${projectPath}"`);

    vscode.window.showInformationMessage(
        'Setting up AI Use Cases for this project...'
    );
}

async function syncUseCases() {
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    if (!workspaceFolder) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const config = vscode.workspace.getConfiguration('aiSessionDocumentor');
    const projectPath = workspaceFolder.uri.fsPath;
    const scriptPath = getScriptPath(config, 'sync-ai-use-cases.sh');

    if (!fs.existsSync(scriptPath)) {
        throw new Error(`Sync script not found: ${scriptPath}`);
    }

    await vscode.window.withProgress(
        {
            location: vscode.ProgressLocation.Notification,
            title: 'Syncing AI Use Cases',
            cancellable: false
        },
        async (progress) => {
            progress.report({ message: 'Syncing to central hub...' });

            const terminal = vscode.window.createTerminal({
                name: 'Sync AI Use Cases',
                cwd: projectPath
            });

            terminal.show();
            terminal.sendText(`bash "${scriptPath}" "${projectPath}"`);

            await new Promise(resolve => setTimeout(resolve, 1000));

            vscode.window.showInformationMessage('Use cases synced to central hub');
        }
    );
}

async function searchUseCases() {
    const config = vscode.workspace.getConfiguration('aiSessionDocumentor');
    const hubPath = expandPath(config.get('hubPath', '~/Documents/ai-use-case-hub'));

    if (!fs.existsSync(hubPath)) {
        vscode.window.showErrorMessage(`Hub not found at: ${hubPath}`);
        return;
    }

    // Ask user what to search for
    const searchTerm = await vscode.window.showInputBox({
        prompt: 'Search AI use cases',
        placeHolder: 'Enter keyword, topic, or technology...'
    });

    if (!searchTerm) {
        return;
    }

    const terminal = vscode.window.createTerminal({
        name: 'Search AI Use Cases',
        cwd: hubPath
    });

    terminal.show();
    terminal.sendText(`echo "Searching for: ${searchTerm}"`);
    terminal.sendText(`echo ""`);
    terminal.sendText(`echo "📁 Files matching '${searchTerm}':"`);
    terminal.sendText(`find by-project -name "*${searchTerm}*" -type f | head -10`);
    terminal.sendText(`echo ""`);
    terminal.sendText(`echo "📝 Content matches:"`);
    terminal.sendText(`grep -r "${searchTerm}" by-project --include="*.md" -l | head -10`);
}

async function viewInHub() {
    const config = vscode.workspace.getConfiguration('aiSessionDocumentor');
    const hubPath = expandPath(config.get('hubPath', '~/Documents/ai-use-case-hub'));

    if (!fs.existsSync(hubPath)) {
        vscode.window.showErrorMessage(`Hub not found at: ${hubPath}`);
        return;
    }

    const choice = await vscode.window.showQuickPick([
        { label: 'By Project', description: 'View use cases organized by project', value: 'by-project' },
        { label: 'By Date', description: 'View use cases chronologically', value: 'by-date' },
        { label: 'By Topic', description: 'View use cases by topic/technology', value: 'by-topic' }
    ], {
        placeHolder: 'How would you like to browse use cases?'
    });

    if (!choice) {
        return;
    }

    const targetPath = path.join(hubPath, choice.value);
    const uri = vscode.Uri.file(targetPath);

    await vscode.commands.executeCommand('revealFileInOS', uri);
}

function getScriptPath(config: vscode.WorkspaceConfiguration, scriptName: string): string {
    const hubPath = expandPath(config.get('hubPath', '~/Documents/ai-use-case-hub'));
    return path.join(hubPath, scriptName);
}

function expandPath(filePath: string): string {
    if (filePath.startsWith('~/')) {
        return path.join(os.homedir(), filePath.substring(2));
    }
    return filePath;
}

export function deactivate() {}
