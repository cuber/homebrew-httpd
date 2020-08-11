require 'formula'

class HttpdAT22 < Formula
  homepage 'http://httpd.apache.org/'
  url 'https://archive.apache.org/dist/httpd/httpd-2.2.23.tar.bz2'
  sha256 '14fe79bd6edd957c02cb41f4175e132c08e6ff74a7d08dc1858dd8224e351c34'

  skip_clean :all

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--enable-layout=GNU",
                          "--enable-mods-shared=all",
                          "--with-mpm=prefork",
                          "--disable-unique-id",
                          "--with-included-apr",
                          "--with-pcre=#{Formula["pcre"].opt_prefix}",
                          "--with-z=#{MacOS.sdk_path_if_needed}/usr"
    system "make"
    system "make install"
  end

  def startup_plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>com.apache.httpd</string>
      <key>ProgramArguments</key>
      <array>
        <string>/usr/local/sbin/apachectl</string>
        <string>start</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
    EOS
  end
end
