{
  pkgs,
  config,
  ...
}: let
  models = [
    "claude-3-opus-latest"
    "claude-3-5-sonnet-latest"
    "claude-3-7-sonnet-latest"
    "claude-4-sonnet-latest"
    "gpt-4o"
    "gpt-4o-mini"
    "o1"
    "gemini-2.0-flash"
    "gemini-2.5-pro"
  ];

  styles = {
    general = {
      role = "system";
      content = ''
        You are a helpful assistant. Provide simple examples when relevant, answer questions clearly.

        When asked to change or provide code, plan before you start. Use codeblocks with language tags for code.
          1. List requirements
          2. Outline approach and considerations
          3. Ask for clarification if needed
      '';
    };
    tldr = {
      role = "system";
      content = "You are a helpful assistant. Answer questions with concise bullet points. Dive right into the point without leader.";
    };
    townie = {
      role = "system";
      content = pkgs.fetchurl {
        url = "https://esm.town/v/std/vtEditorFiles/.cursorrules";
        hash = "sha256-t0BWARHt5/b2g5pHOpvYdFjOS144vObskzRzncwMmaU=";
      };
    };
  };

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
