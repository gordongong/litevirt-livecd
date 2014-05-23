Name:           ConInit
Version:        0.1
Release:        1%{?dist}
Source0:        %{name}-%{version}.tar
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
cp "exportdb.sh" $RPM_BUILD_ROOT/etc/template/
cp "importdb.sh" $RPM_BUILD_ROOT/etc/template/
cp "etc.tar.gz" $RPM_BUILD_ROOT/etc/template/
cp "db.tar.gz" $RPM_BUILD_ROOT/etc/template/
cp "bos_init" $RPM_BUILD_ROOT/usr/bin/

%files
%attr(0644,root,root) /etc/template/exportdb.sh
%attr(0644,root,root) /etc/template/importdb.sh
%attr(0644,root,root) /etc/template/etc.tar.gz
%attr(0644,root,root) /etc/template/db.tar.gz
%attr(0755,root,root) /usr/bin/bos_init

%changelog
* Thu May 22 2014 bohai <boh.ricky@gmail.com> - 0.1
- Update to upstream 0.1 release

