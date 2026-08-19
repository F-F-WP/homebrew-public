class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.2.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.3/ax-link_1.2.3_darwin_arm64.tar.gz"
      sha256 "7dd63cc4c89d43fcf03c1c926cdaa9e498a4a3c51c883cfe0df220ce717bb61a"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.3/ax-link_1.2.3_darwin_amd64.tar.gz"
      sha256 "e0976376b7fd99f128b3886e468c02d311244ff9d60d80014da437eec6e27f66"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.3/ax-link_1.2.3_linux_arm64.tar.gz"
      sha256 "8aa8953c624e45c0b954c4127311fa60b41d7e75362388d44b8fde2375eb5dfb"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.3/ax-link_1.2.3_linux_amd64.tar.gz"
      sha256 "f40bc2593adc811614baa3319aaca7586465189bbf12b04576477f16e7315f49"
    end
  end

  def install
    bin.install "ax-link"
  end

  test do
    assert_match "ax-link #{version}", shell_output("#{bin}/ax-link version")
  end
end
