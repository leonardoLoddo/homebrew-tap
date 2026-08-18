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
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.1.1/hydra-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "d51400fa5fd8b1f9034b950cf7d70f551930d45eb2322758a5546176071e2934"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.1.1/hydra-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "a33b1c3d3fbf646e6d3cde7af978bcc54fdcf0f8778b674b5d1240eff7c8cb1b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.1.1/hydra-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a225b23a1efa0988fecf0366b83d1b3d9065ec624f94df0a49cf098a05571db"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v0.1.1/hydra-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "509369ebff6acc166a6a3dc800460ed675593d40e41033be15c32be692123230"
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
