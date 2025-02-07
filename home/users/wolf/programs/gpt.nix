{config, ...}: let
  basePrompt = {
    role = "system";
    content = "Be concise. Use code examples when helpful. Only elaborate if asked.";
  };
in {
  home.file."${config.xdg.configHome}/gpt-cli/gpt.yml".text = builtins.toJSON {
    default_assistant = "main";
    markdown = true;
    log_file = "${config.xdg.dataHome}/gpt.log";
    log_level = "INFO";
    assistants = {
      claude = {
        model = "claude-3-opus-20240229";
        messages = [basePrompt];
      };
      cheap-claude = {
        model = "claude-3-5-sonnet-20241022";
        messages = [basePrompt];
      };
      main = {
        model = "gpt-4o";
        messages = [basePrompt];
      };
    };
  };
}
