{config, ...}: let
  prompts = {
    code = {
      role = "system";
      content = ''
        Before implementing any changes:
        1. List the request/requirements
        2. Outline what you will do
        3. Note how you will implement it
        4. Highlight important considerations
        5. If there is important ambiguity ask follow up question to get clarification.

        After listing the above, always put code in a codeblock with appropriate language tag.

        When providing code:
        - Be concise
        - Only elaborate if asked
        - Provide simple examples when relevant
        - Never modify or remove existing comments, docstrings, or documentation
        - When making changes, provide the complete updated code
        - Only modify what was specifically requested
      '';
    };
    regular = {
      role = "system";
      content = ''
        Before implementing any changes:
        1. List the request/requirements
        2. Outline what you will do
        3. Note how you will implement it
        4. Highlight important considerations
        5. If there is important ambiguity ask follow up question to get clarification.

        When responding:
        - Be concise
        - Only elaborate if asked
        - Provide simple examples when relevant
      '';
    };
    tldr = {
      role = "system";
      content = ''
        Provide extremely concise responses:
        - Maximum 2-3 sentences
        - Focus on key points only
        - Use bullet points when possible
        - Skip detailed explanations
      '';
    };
  };
  models = {
    opus = "claude-3-opus-20240229";
    sonnet = "claude-3-5-sonnet-20241022";
    gpt4o = "gpt-4o";
  };
  makeAssistants =
    builtins.mapAttrs (
      name: model:
        builtins.mapAttrs (promptName: prompt: {
          inherit model;
          messages = [prompt];
        })
        prompts
    )
    models;
  flattenAssistants =
    builtins.mapAttrs (
      modelName: modelAssistants:
        builtins.mapAttrs (
          promptName: assistant: "${modelName}${
            if promptName == "regular"
            then ""
            else "-${promptName}"
          }"
        )
        modelAssistants
    )
    makeAssistants;
in {
  home.file."${config.xdg.configHome}/gpt-cli/gpt.yml".text = builtins.toJSON {
    default_assistant = "main";
    markdown = true;
    log_file = "${config.xdg.dataHome}/gpt.log";
    log_level = "INFO";
    assistants = flattenAssistants;
  };
}
