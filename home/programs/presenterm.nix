{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    mermaid-cli
    python313Packages.weasyprint
  ];
  imports = [
    ../modules/presenterm-options.nix
  ];

  unstable-presenterm = {
    enable = true;

    defaults = {
      theme = "dark";
      image_protocol = "kitty-local";
    };

    options = {
      implicit_slide_ends = true;
      auto_render_languages = ["mermaid"];
      command_prefix = "cmd:";
      list_item_newlines = 2;
    };

    snippet = {
      exec.enable = true;
      render.threads = 4;
    };

    mermaid.scale = 4;
    d2.scale = 2;

    bindings = {
      next = ["l" "j" "<right>" "<page_down>" "<down>" " "];
      previous = ["h" "k" "<left>" "<page_up>" "<up>"];
      next_fast = ["n"];
      previous_fast = ["p"];
      first_slide = ["gg"];
      last_slide = ["G"];
      go_to_slide = ["<number>G"];
      execute_code = ["<c-e>"];
      reload = ["<c-r>"];
      toggle_slide_index = ["<c-p>"];
      toggle_bindings = ["?"];
      close_modal = ["<esc>"];
      exit = ["<c-c>" "q"];
      suspend = ["<c-z>"];
    };
  };
}
