# typed: strict
# frozen_string_literal: true

# Formula for the Hydra Git-native workspace manager.
class HydraHeads < Formula
  desc "Git-native workspace manager for isolated development Heads"
  homepage "https://github.com/leonardoLoddo/hydra"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on "git"

  on_macos do
    on_arm do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.1.0/hydra-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "07b6ae29cfd7ad9c050c724e116c7b573f8415e00e6f41a47f69f7cc71fa18ce"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.1.0/hydra-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "209523b65c3e4de7946af7191a968ec6b5856ff7a70bcece1d34ec903263f361"
    end
  end

  conflicts_with "hydra", because: "both install a hydra executable"
  conflicts_with "ory-hydra", because: "both install a hydra executable"

  def install
    bin.install "hydra"
    pkgshare.install "hydra-art.txt"
    pkgshare.install "skills"
    pkgshare.install "LICENSE", "LICENSE-MIT", "LICENSE-APACHE"
  end

  def caveats
    art = (pkgshare/"hydra-art.txt").read
    "#{art}\nGet started:\n  hydra --help\n\nOptional Codex skill:\n  hydra skill install codex\n"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hydra --version")
    ENV["HOME"] = testpath
    system bin/"hydra", "skill", "install", "codex", "--yes"
    system bin/"hydra", "skill", "status", "codex"
    system bin/"hydra", "skill", "remove", "codex", "--yes"
  end
end
