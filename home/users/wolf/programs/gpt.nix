{config, ...}: let
  basePrompt = {
    role = "system";
    content = "Be concise. Only elaborate if asked, try to provide simple examples. When asked to update/change/add to code, provide the full code with the changes, and make no changes to comments, docstrings, or anything other than was asked.";
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
