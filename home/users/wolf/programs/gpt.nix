{config, ...}: let
  # Define system prompts for different assistant types
  prompts = {
    regular = {
      role = "system";
      content = ''
        When responding:
        - Be concise
        - Only elaborate if asked
        - Provide simple examples when relevant
      '';
    };
    code = {
      role = "system";
      content = ''
        Before implementing any changes:
        1. List the request/requirements
        2. Outline what you will do, and important considerations
        3. If there is important ambiguity ask follow up question to get clarification

        After listing the above, always put code in a codeblock with appropriate language tag.

        When providing code:
        - Be concise
        - Only elaborate if asked
        - Provide simple examples when relevant
        - Never modify or remove existing comments, docstrings, or documentation
        - When making changes, provide the complete updated code
        - Only modify what was specifically requested
        - The code should be the last part of your message, and there should be nothing after your codeblock
      '';
    };
    tldr = {
      role = "system";
      content = ''
        Provide extremely concise responses:

        - Don't say more than you need
        - Ensure you answer the question
        - Use bullet points when possible
        - Only provide examples if asked
      '';
    };
  };

  # Define available models
  models = {
    opus = "claude-3-opus-latest";
    sonnet = "claude-3-5-sonnet-latest";
    gpt4o = "gpt-4o";
    gpt4o-mini = "gpt-4o-mini";
    gpto1 = "o1";
  };

  # Create assistant configurations for each model and prompt combination
  makeAssistants = let
    # For each model, create assistants with all prompt types
    makeModelAssistants = modelName: modelValue:
      builtins.mapAttrs (promptName: promptValue: {
        name =
          if promptName == "regular"
          then modelName
          else "${modelName}-${promptName}";
        value = {
          model = modelValue;
          messages = [promptValue];
        };
      })
      prompts;

    # Combine all model-specific assistants into a single set
    allAssistants = builtins.foldl' (
      acc: modelName:
        acc // (makeModelAssistants modelName models.${modelName})
    ) {} (builtins.attrNames models);
  in
    allAssistants;
in {
  # Generate the YAML configuration file
  # This will create a file at $XDG_CONFIG_HOME/gpt-cli/gpt.yml
  home.file."${config.xdg.configHome}/gpt-cli/gpt.yml".text = builtins.toJSON {
    # Default configuration
    default_assistant = "regular";
    markdown = true;
    log_file = "${config.xdg.dataHome}/gpt.log";
    log_level = "INFO";
    # Generated assistant configurations
    assistants = makeAssistants;
  };
}
