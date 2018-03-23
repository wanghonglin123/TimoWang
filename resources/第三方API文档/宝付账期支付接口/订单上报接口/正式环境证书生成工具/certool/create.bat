@echo off
set OPENSSL_CONF=./openssl.cnf
rem ------------------------------------------------------------------
echo ������Կ���ɹ���
rem ------------------------------------------------------------------
set /p name=������֤������(�س�Ĭ�� keyfile): 
if "%name%"=="" set name="keyfile"
set /p storepass=������˽Կ����(�س�Ĭ�� 123456): 
if "%storepass%"=="" set storepass="123456"

rem ------------------------------------------------------------------
echo ����˽Կ
rem ------------------------------------------------------------------
openssl.exe genrsa -out %name%_pri.key 1024

rem ------------------------------------------------------------------
echo ����֤������
rem ------------------------------------------------------------------
openssl.exe req -new -key %name%_pri.key -out %name%_pri.csr -days 3650 -subj "/CN=RootCA/OU=Baofoo/O=Baofoo/L=Shanghai/ST=Shanghai/C=CN"

rem ------------------------------------------------------------------
echo ��������֤��
rem ------------------------------------------------------------------
openssl.exe req -new -x509 -key %name%_pri.key -out %name%_pub.cer -days 3650 -subj "/CN=RootCA/OU=Baofoo/O=Baofoo/L=Shanghai/ST=Shanghai/C=CN"
rem ------------------------------------------------------------------

echo ��˽Կ��֤��ϲ���PFX�ļ�
rem ------------------------------------------------------------------
openssl.exe pkcs12 -export -in %name%_pub.cer -inkey %name%_pri.key -out %name%_pri.pfx -passout pass:%storepass% -name "%name%_alias"

rem ------------------------------------------------------------------
echo ����м��ļ�
rem ------------------------------------------------------------------
del %name%_pri.key
del %name%_pri.csr


