class AxLink < Formula
  desc "Connect AX Link models to supported AI provider runtimes"
  homepage "https://github.com/F-F-WP/homebrew-public"
  version "1.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.4/ax-link_1.2.4_darwin_arm64.tar.gz"
      sha256 "41b29fca54f9bbf1fa87b6144eeda9f3af5af20c75945fe8ae054e05aca64629"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.4/ax-link_1.2.4_darwin_amd64.tar.gz"
      sha256 "7c92b40ab3de4c0046420efda4c3e5ea18cb0a454c7a3c90948206787d316101"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.4/ax-link_1.2.4_linux_arm64.tar.gz"
      sha256 "c4cd562f797bfc5b1b36c9badad384fb5c8248ec82d1ea536deba057a0ef1925"
    else
      url "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v1.2.4/ax-link_1.2.4_linux_amd64.tar.gz"
      sha256 "9084c71bdc811b704b1c22ff1e570c8173ef5e5e5e1090ee69e4cb405d9ab5e5"
    end
  end

  def install
    bin.install "ax-link"
  end

  test do
    assert_match "ax-link #{version}", shell_output("#{bin}/ax-link version")
  end
end
