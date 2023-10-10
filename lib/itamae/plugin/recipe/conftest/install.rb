version = Itamae::Plugin::Recipe::Conftest::CONFTEST_VERSION

execute "download conftest v#{version}" do
  cwd '/tmp'
  command <<-EOF
    rm -f conftest_#{version}_Linux_x86_64.tar.gz
    wget https://github.com/open-policy-agent/conftest/releases/download/v#{version}/conftest_#{version}_Linux_x86_64.tar.gz
  EOF
  not_if "test -e /usr/local/bin/conftest && /usr/local/bin/conftest -v | egrep '.* #{version}$'"
end

execute "install conftest v#{version}" do
  cwd '/tmp'
  command <<-EOF
    rm -f conftest
    tar xzf conftest_#{version}_Linux_x86_64.tar.gz
    sudo mv -f conftest /usr/local/bin/
  EOF
  not_if "test -e /usr/local/bin/conftest && /usr/local/bin/conftest -v | egrep '.* #{version}$'"
end
