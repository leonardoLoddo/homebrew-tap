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
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.0.0/hydra-1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "b47d82065cb947575ad570893c912481bf33b82b29e594fb5529e435648d4738"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.0.0/hydra-1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "44ca35e67495798193959d8953f33723904d11189aa04cec5ad0fc76510aca4a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.0.0/hydra-1.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "749870a20458c6b7d3ec17916df5622a5fd7d3302feb8c2860f110ffcd7be907"
    end
    on_intel do
      url "https://github.com/leonardoLoddo/hydra/releases/download/v1.0.0/hydra-1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4e6183cc3b97928f81f041e390d629ce5fbe074acb67089468a08f77cff2f994"
    end
  end

  conflicts_with "hydra", because: "both install a hydra executable"
  conflicts_with "ory-hydra", because: "both install a hydra executable"

  def install
    bin.install "hydra"
    generate_completions_from_executable(bin/"hydra", shell_parameter_format: :clap)
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
