class MdbtoolsKi < Formula
  desc "MDB Tools - Read Access databases on *nix with -c and -C flags"
  homepage "https://github.com/jjbreen3ki/mdbtools-ki"
  url "https://github.com/jjbreen3ki/mdbtools-ki/archive/refs/tags/1.0.1-b.tar.gz"
  sha256 "87750c369d966137ecbc7a842eb6f7c4452dd70959e59e5583394ea57fbab024"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/jjbreen3ki/homebrew-tap/releases/download/mdbtools-ki-1.0.1"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "53440d669a355453355fb4ede4ba07134b87ab59f9ee8380da3009a26f4f23f4"
    sha256 cellar: :any,                 arm64_sequoia: "22b37d022def173859cd9d7984b27d5e279bca40e32d2cc367a4a2b1b4e6f0bb"
    sha256 cellar: :any,                 arm64_sonoma:  "623032644ee9925a2e5ce202bba84645859c66b2c04a7616a055b7b2be10b3b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "31c6efa7887918f29fee5843771af394772ebc16545c187268d332157b9d7713"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "bison" => :build
  depends_on "gawk" => :build
  depends_on "gettext" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  depends_on "glib"
  depends_on "readline"

  on_macos do
    depends_on "gettext"
  end

  def install
    system "autoreconf", "--force", "--install", "--verbose", "-I", "#{ENV["HOMEBREW_PREFIX"]}/share/gettext/m4"
    system "./configure", "--enable-man", "--program-suffix=-ki", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/mdb-schema-ki --drop-table test 2>&1", 1)

    expected_output = <<~EOS
      File not found
      Could not open file
    EOS
    assert_match expected_output, output
  end
end
