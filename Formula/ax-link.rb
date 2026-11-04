class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.2/ax-link_1.3.2_darwin_arm64.tar.gz"
      sha256 "e10ff70fe5c2373076812ecf4477c005e20551eb1f1ec1e1111808b83b2a66dc"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.2/ax-link_1.3.2_darwin_amd64.tar.gz"
      sha256 "a0c190a9567ac67e7fb587f9cbc7691c8e4efce8f92841b283d63c7f6627cadb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.2/ax-link_1.3.2_linux_arm64.tar.gz"
      sha256 "d0ce6199716ca9341c5f9439d21db99c849f12ab8c551e7d234397a7202ab4e3"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.3.2/ax-link_1.3.2_linux_amd64.tar.gz"
      sha256 "561b083b46a39e6a97f0762ddcdbd6955ecc5449687280ec13f45f825a069d60"
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
