Name:           ConInit
Version:        0.1
Release:        1%{?dist}
Source0:        %{name}.tar
Summary:        litevirt controller initialize tools
Group:          Development/Tools
License:        LGPLv2+
URL:            https://github.com/litevirt
Buildarch: noarch

%description
This tool allows user to initlize the openstack controller.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/etc/template
cp "export.sh" $RPM_BUILD_ROOT/etc/template/
cp "import.sh" $RPM_BUILD_ROOT/etc/template/
cp "etc.tar.gz" $RPM_BUILD_ROOT/etc/template/
cp "db.tar.gz" $RPM_BUILD_ROOT/etc/template/

%files
%attr(0644,root,root) /etc/template/export.sh
%attr(0644,root,root) /etc/template/import.sh
%attr(0644,root,root) /etc/template/etc.tar.gz
%attr(0644,root,root) /etc/template/db.tar.gz

%changelog
* Thu May 22 2014 bohai <boh.ricky@gmail.com> - 0.1
- Update to upstream 0.1 release

