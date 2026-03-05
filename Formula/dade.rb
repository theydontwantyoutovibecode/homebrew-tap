# typed: false
# frozen_string_literal: true

class Dade < Formula
  desc "CLI for scaffolding, developing, and serving projects with zero-friction HTTPS"
  homepage "https://github.com/theydontwantyoutovibecode/dade"
  url "https://github.com/theydontwantyoutovibecode/dade.git",
    tag: "v1.3.0"
  license "MIT"

  depends_on "go" => :build
  depends_on "caddy"
  depends_on "git"
  depends_on "jq"
  depends_on "wedow/tap/ticket"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/theydontwantyoutovibecode/dade/internal/version.Version=#{version}"), "./cmd/dade"
  end

  def caveats
    <<~EOS
      Optional dependencies for additional features:
        brew install cloudflared  # public tunnels via dade share
    EOS
  end

  test do
    assert_match "dade v#{version}", shell_output("#{bin}/dade version")
  end
end
