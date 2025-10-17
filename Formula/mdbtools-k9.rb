class MdbtoolsK9 < Formula
  desc "MDB Tools - Read Access databases on *nix"
  homepage "https://github.com/jjbreen3ki/mdbtools-ki"
  url "https://github.com/jjbreen3ki/mdbtools-ki/archive/refs/tags/1.0.1-a.zip"
  sha256 "b73dc8c35f794c3f89eeef1cbc68c6df3e7a3cf6fe6a2c99e0acdbd2d5e218f4"
  license "GPL-2.0"

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
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--enable-man", "--program-suffix=-k9", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/mdb-schema-k9 --drop-table test 2>&1", 1)

    expected_output = <<~EOS
      File not found
      Could not open file
    EOS
    assert_match expected_output, output
  end

end
