class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.2/ax-link_1.2.2_darwin_arm64.tar.gz"
      sha256 "add0a7debb558669f68ff35cce9cb02c1317b0a5b95875401659044f66299790"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.2/ax-link_1.2.2_darwin_amd64.tar.gz"
      sha256 "2006463a8aac9fdb7b366e31ade6320624a8afdce311743275ee47c1571c1feb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.2/ax-link_1.2.2_linux_arm64.tar.gz"
      sha256 "099687b8cfa53b0bda04e7860fa8269aa6bfd691ea27a849d7d977f0811890b5"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.2/ax-link_1.2.2_linux_amd64.tar.gz"
      sha256 "45a4d26d157584cdedeba4a2d83c91b2fc66ef9e35b48040cde9f64b86254dc3"
    end
  end

  def install
    bin.install "ax-link"
  end

  test do
    assert_match "ax-link #{version}", shell_output("#{bin}/ax-link version")
  end
end
