{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      bbenoist.nix
      ms-python.python
      myriad-dreamin.tinymist
      ms-python.python
      ms-toolsai.jupyter
    ];

    profiles.default.userSettings = {
      "tinymist.serverPath" = "${pkgs.tinymist}/bin/tinymist";

      "files.autoSave" = "afterDelay";
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.lineNumbers" = "relative";

      # disbale spyware
      "telemetry.telemetryLevel" = "off";
      "telemetry.enableTelemetry" = false;
      "telemetry.enableCrashReporter" = false;

      # nixos handles updates
      "update.mode" = "none";
      "update.showReleaseNotes" = false;

      # no network requests for you microsoft
      "workbench.settings.enableNaturalLanguageSearch" = false;
      "workbench.enableExperiments" = false;
      "workbench.tips.enabled" = false;
      "typescript.surveys.enabled" = false;
      "npm.fetchOnlinePackageInfo" = false;

      "search.useIgnoreFiles" = true;
      "editor.suggest.snippetsPreventQuickSuggestions" = false;

      "redhat.telemetry.enabled" = false;

      # disable ai shit
      "workbench.commandPalette.showAskInChat" = false;
      "accessibility.verboseChatProgressUpdates" = false;
      "accessibility.verbosity.inlineChat" = false;
      "accessibility.verbosity.panelChat" = false;
      "chat.agent.enabled" = false;
      "chat.agent.thinking.collapsedTools" = "none";
      "chat.agentSessionsViewLocation" = "disabled";
      "chat.checkpoints.enabled" = false;
      "chat.commandCenter.enabled" = false;
      "chat.detectParticipant.enabled" = false;
      "chat.editing.confirmEditRequestRemoval" = false;
      "chat.editing.confirmEditRequestRetry" = false;
      "chat.implicitContext.suggestedContext" = false;
      "chat.math.enabled" = false;
      "chat.sendElementsToChat.attachCSS" = false;
      "chat.sendElementsToChat.attachImages" = false;
      "chat.sendElementsToChat.enabled" = false;
      "chat.showAgentSessionsViewDescription" = false;
      "chat.todoListTool.descriptionField" = false;
      "chat.tools.terminal.enableAutoApprove" = false;
      "chat.tools.terminal.outputLocation" = "none";
      "chat.tools.todos.showWidget" = false;
      "chat.undoRequests.restoreInput" = false;
      "chat.useAgentsMdFile" = false;
      "chat.useCloudButtonV2" = false;
      "chat.disableAIFeatures" = true;
    };
  };
}
