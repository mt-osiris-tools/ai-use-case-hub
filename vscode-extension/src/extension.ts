import * as vscode from 'vscode';
import * as cp from 'child_process';
import * as path from 'path';
import * as os from 'os';

export function activate(context: vscode.ExtensionContext) {
    console.log('AI Session Documentor extension is now active');

    const documentSessionCommand = vscode.commands.registerCommand(
        'aiSessionDocumentor.documentSession',
        async () => {
            try {
                await documentAISession();
            } catch (error) {
                vscode.window.showErrorMessage(
                    `Failed to document AI session: ${error instanceof Error ? error.message : String(error)}`
                );
            }
        }
    );

    context.subscriptions.push(documentSessionCommand);
}

async function documentAISession() {
    const config = vscode.workspace.getConfiguration('aiSessionDocumentor');

    // Check if enabled
    if (!config.get('enabled', true)) {
        vscode.window.showInformationMessage('AI Session Documentor is disabled');
        return;
    }

    // Get workspace folder
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0];
    if (!workspaceFolder) {
        vscode.window.showErrorMessage('No workspace folder open');
        return;
    }

    const projectPath = workspaceFolder.uri.fsPath;

    // Get script path from configuration
    let scriptPath = config.get('scriptPath', '~/Documents/ai-use-cases/document-ai-session.sh');

    // Expand ~ to home directory
    if (scriptPath.startsWith('~/')) {
        scriptPath = path.join(os.homedir(), scriptPath.substring(2));
    }

    // Show progress
    await vscode.window.withProgress(
        {
            location: vscode.ProgressLocation.Notification,
            title: 'Documenting AI Session',
            cancellable: false
        },
        async (progress) => {
            progress.report({ message: 'Launching interactive session...' });

            try {
                // Check if script exists
                const fs = require('fs');
                if (!fs.existsSync(scriptPath)) {
                    throw new Error(`Script not found: ${scriptPath}`);
                }

                // Execute script in integrated terminal
                const terminal = vscode.window.createTerminal({
                    name: 'AI Session Documentor',
                    cwd: projectPath
                });

                terminal.show();
                terminal.sendText(`bash "${scriptPath}" "${projectPath}"`);

                // Wait a moment for terminal to start
                await new Promise(resolve => setTimeout(resolve, 500));

                vscode.window.showInformationMessage(
                    'Follow the prompts in the terminal to document your AI session'
                );

            } catch (error) {
                throw error;
            }
        }
    );
}

export function deactivate() {}
