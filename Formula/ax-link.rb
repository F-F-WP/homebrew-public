class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.0/ax-link_1.3.0_darwin_arm64.tar.gz"
      sha256 "7de166b3c03729c54aed8b6c22e1de9313643724f9de08e5e0a3754b72da8df2"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.0/ax-link_1.3.0_darwin_amd64.tar.gz"
      sha256 "4e85691952d542a5f60cc51180f588de756289edc805f1678be32e58bb55c85c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.0/ax-link_1.3.0_linux_arm64.tar.gz"
      sha256 "3f022f78c5353dd624c4b1daada3344b2de3362a85fd00b6047b15f8cfa356dd"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.0/ax-link_1.3.0_linux_amd64.tar.gz"
      sha256 "d569020c7f74c7ca53a477516b03063e385d21f07160789cd88695f92263adcf"
    end
  end

  def install
    bin.install "ax-link"
  end

  test do
    assert_match "ax-link #{version}", shell_output("#{bin}/ax-link version")
    assert_match "ax-link setup orca", shell_output("#{bin}/ax-link help")
  end
end
