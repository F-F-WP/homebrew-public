class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.0/ax-link_1.2.0_darwin_arm64.tar.gz"
      sha256 "317c31963488aba6eb88366bf3ad0798436cf719cf657afc104ce147a443fff3"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.0/ax-link_1.2.0_darwin_amd64.tar.gz"
      sha256 "c370f13e30336105e8e8870369e31fe54cd5de33a3c36218dc115ae0fca5eac8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.0/ax-link_1.2.0_linux_arm64.tar.gz"
      sha256 "8a0fdbb429e75a6318371ea972aee2d839d9f70d606b31b0a4dd5fff333caa40"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.0/ax-link_1.2.0_linux_amd64.tar.gz"
      sha256 "7ac11fa11cfcf6b99eb4401dbdd50346235d5a6d4c620cd1311b4033f90288e8"
    end
  end

  def install
    bin.install "ax-link"
  end

  test do
    assert_match "ax-link #{version}", shell_output("#{bin}/ax-link version")
  end
end
