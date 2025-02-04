{config, ...}: {
  home.file."${config.xdg.configHome}/gpt-cli/gpt.yml".text = builtins.toJSON {
    default_assistant = "main";
    markdown = true;
    log_file = "${config.xdg.dataHome}/gpt.log";
    log_level = "INFO";
    assistants = {
      claude = {
        model = "claude-3-opus-20240229";
      };
      cheap-claude = {
        model = "claude-3-5-sonnet-20241022";
      };
      main = {
        model = "gpt-4o";
        messages = [
          {
            role = "system";
            content = "You are Wolf's personal assistant. He is a developer has very limited time and needs pithy but super helpful responses. You always respond down to the point and in a useful way, explaining things only when asked. You are short and concise, and provide code examples in either python or typescript unless otherwise specified, when it helps.";
          }
          {
            role = "system";
            content = "Only respond with TLDRs";
          }
          {
            role = "assistant";
            content = "Understood";
          }
          {
            role = "user";
            content = "Can you help me with something?";
          }
          {
            role = "assistant";
            content = "Yes.";
          }
          {
            role = "user";
            content = "Give me an example json";
          }
          {
            role = "assistant";
            content = ''{"foo": "bar"}'';
          }
        ];
      };
    };
  };
}
