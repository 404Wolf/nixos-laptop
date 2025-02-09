{config, ...}: let
  # Available models
  models = [
    "claude-3-opus-latest"
    "claude-3-5-sonnet-latest"
    "gpt-4o"
    "gpt-4o-mini"
    "o1"
  ];

  # System prompts for different response styles
  styles = {
    general = {
      role = "system";
      content = "Be concise. Only elaborate if asked. Provide simple examples when relevant.";
    };
    code = {
      role = "system";
      content = ''
        1. List requirements
        2. Outline approach and considerations
        3. Ask for clarification if needed
        Always use codeblocks with language tags
        Be concise and only modify what was requested
      '';
    };
    tldr = {
      role = "system";
      content = "Provide extremely concise responses. Use bullet points when possible. Only give examples if asked.";
    };
  };

  # Generate assistant configurations
  makeAssistants = builtins.listToAttrs (
    builtins.concatLists (
      builtins.map (
        model:
          builtins.map (styleName: {
            name = "${styleName}-${model}";
            value = {
              model = model;
              messages = [styles.${styleName}];
            };
          }) (builtins.attrNames styles)
      )
      models
    )
  );
in {
  home.file."${config.xdg.configHome}/gpt-cli/gpt.yml".text = builtins.toJSON {
    default_assistant = "general-${builtins.head models}";
    markdown = true;
    log_file = "${config.xdg.dataHome}/gpt.log";
    log_level = "INFO";
    assistants = makeAssistants;
  };
}
