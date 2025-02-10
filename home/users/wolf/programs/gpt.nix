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
      content = ''
        You are a helpful assistant. Provide simple examples when relevant, answer questions clearly.

        If you are asked to change or provide code, plan before you start. Use codeblocks with language tags for code.
          1. List requirements
          2. Outline approach and considerations
          3. Ask for clarification if needed
        If you are asked to change code or add something to it, always provide the exact same code provided, but with the requested changes, and keep their comments, docstrings, etc, and don't use "..."s.
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
