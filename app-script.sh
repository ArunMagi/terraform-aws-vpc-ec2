#!/bin/bash

sudo su

sudo apt  update

sudo apt install -y  docker.io

sleep 10s


sudo apt-get update && apt-get install -y apt-transport-https curl

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

 sleep 10s

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sleep 10s

sudo apt-get update

sudo apt-get install -y kubelet=1.20.0-00 kubeadm=1.20.0-00 kubectl=1.20.0-00

sudo systemctl start docker && sudo systemctl enable docker

echo '1' > /proc/sys/net/ipv4/ip_forward
modprobe bridge
modprobe br_netfilter

sudo apt install -y  apache2

sudo a2enmod proxy_http

sudo a2enmod ssl

sudo a2ensite default-ssl

sudo mkdir -p /etc/apache2/ssl

touch /etc/apache2/ssl/cts-2023-ca.crt

touch /etc/apache2/ssl/cts-2023.crt

touch /etc/apache2/ssl/cts-2023.key

cat <<EOF > /etc/apache2/ssl/cts-2023-ca.crt

-----BEGIN CERTIFICATE-----
MIIEijCCA3KgAwIBAgIQfU1CqStDHX5kU+fBmo1YdzANBgkqhkiG9w0BAQsFADBX
MQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEQMA4GA1UE
CxMHUm9vdCBDQTEbMBkGA1UEAxMSR2xvYmFsU2lnbiBSb290IENBMB4XDTIyMTAx
MjAzNDk0M1oXDTI3MTAxMjAwMDAwMFowTDELMAkGA1UEBhMCQkUxGTAXBgNVBAoT
EEdsb2JhbFNpZ24gbnYtc2ExIjAgBgNVBAMTGUFscGhhU1NMIENBIC0gU0hBMjU2
IC0gRzQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtJCmVZhWIPzOH
A3jP1QwkuDFT8/+DImyZlSt85UpZwq7G0Sqd+n8gLlHIZypQkad5VkT7OLU+MI78
lC7LVwxpU19ExlaWL67ANyWG8XHx3AJFQoZhuDbvUeNzRQyQs6XS5wN6uDlF0Bf1
AtCUQWrGGLGYwyC1xTrzgrFKpESsIXMqklUGTsh8i7DKZhRUVfgrPLJUkbbLUrLY
42+KRCiwfSvBloC5PgDYnj3oMZ1aTe3Wfk3l1I4D3RKaJ4PU1qHXhHJOge2bjGIG
l6MsaBN+BB2sr6EnxX0xnMIbew2oIfOFoLqs47vh/GH4JN0qql2WBHfDPVDm3b+G
QxY6N/LXAgMBAAGjggFbMIIBVzAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYI
KwYBBQUHAwEGCCsGAQUFBwMCMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYE
FE/LrKjC76vdg29rv86YPVxYJXYVMB8GA1UdIwQYMBaAFGB7ZhpFDZfKiVAvfQTN
NKj//P1LMHoGCCsGAQUFBwEBBG4wbDAtBggrBgEFBQcwAYYhaHR0cDovL29jc3Au
Z2xvYmFsc2lnbi5jb20vcm9vdHIxMDsGCCsGAQUFBzAChi9odHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXIxLmNydDAzBgNVHR8ELDAqMCig
JqAkhiJodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QuY3JsMCEGA1UdIAQa
MBgwCAYGZ4EMAQIBMAwGCisGAQQBoDIKAQMwDQYJKoZIhvcNAQELBQADggEBABol
9nNkiECpWQenQ7oVP1FhvRX/LWTdzXpdMmp/SELnEJhoOe+366E0dt8tWGg+ezAc
DPeGYPmp83nAVLeDpji7Nqu8ldB8+G/B6U9GB8i2DDIAqSsFEvcMbWb5gZ2/DmRN
cifGi9FKAuFu2wyft4s4DHwzL2CJ2zjMlUOM3RaE1cxuOs+Om6MCD9G7vnkAtSiC
/OOfHO902f4yI2a48K+gKaAf3lISFXjd32pwQ21LpM3ueIGydaJ+1/z8nv+C7SUT
5bHoz7cYU27LUvh1n2WSNnC6/QwFSoP6gNKa4POO/oO13xjhrLRHJ/04cKMbRALt
JWQkPacJ8SJVhB2R7BI=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDdTCCAl2gAwIBAgILBAAAAAABFUtaw5QwDQYJKoZIhvcNAQEFBQAwVzELMAkG
A1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExEDAOBgNVBAsTB1Jv
b3QgQ0ExGzAZBgNVBAMTEkdsb2JhbFNpZ24gUm9vdCBDQTAeFw05ODA5MDExMjAw
MDBaFw0yODAxMjgxMjAwMDBaMFcxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxT
aWduIFJvb3QgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDaDuaZ
jc6j40+Kfvvxi4Mla+pIH/EqsLmVEQS98GPR4mdmzxzdzxtIK+6NiY6arymAZavp
xy0Sy6scTHAHoT0KMM0VjU/43dSMUBUc71DuxC73/OlS8pF94G3VNTCOXkNz8kHp
1Wrjsok6Vjk4bwY8iGlbKk3Fp1S4bInMm/k8yuX9ifUSPJJ4ltbcdG6TRGHRjcdG
snUOhugZitVtbNV4FpWi6cgKOOvyJBNPc1STE4U6G7weNLWLBYy5d4ux2x8gkasJ
U26Qzns3dLlwR5EiUWMWea6xrkEmCMgZK9FGqkjWZCrXgzT/LCrBbBlDSgeF59N8
9iFo7+ryUp9/k5DPAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBRge2YaRQ2XyolQL30EzTSo//z9SzANBgkqhkiG9w0B
AQUFAAOCAQEA1nPnfE920I2/7LqivjTFKDK1fPxsnCwrvQmeU79rXqoRSLblCKOz
yj1hTdNGCbM+w6DjY1Ub8rrvrTnhQ7k4o+YviiY776BQVvnGCv04zcQLcFGUl5gE
38NflNUVyRRBnMRddWQVDf9VMOyGj/8N7yy5Y0b2qvzfvGn9LhJIZJrglfCm7ymP
AbEVtQwdpf5pLGkkeB6zpxxxYu7KyJesF12KwvhHhm4qxFYxldBniYUr+WymXUad
DKqC5JlR3XC321Y9YeRq4VzW9v493kHMB65jUr9TU/Qr6cf9tveCX4XSQRjbgbME
HMUfpIBvFSDJ3gyICh3WZlXi/EjJKSZp4A==
-----END CERTIFICATE-----

EOF

cat <<EOF > /etc/apache2/ssl/cts-2023.crt

-----BEGIN CERTIFICATE-----
MIIGbTCCBVWgAwIBAgIME4xS1URKWQmmGHnLMA0GCSqGSIb3DQEBCwUAMEwxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSIwIAYDVQQDExlB
bHBoYVNTTCBDQSAtIFNIQTI1NiAtIEc0MB4XDTIzMDMxNzA2NTUwMVoXDTI0MDQx
NzA2NTUwMFowJjEkMCIGA1UEAwwbKi5jb252ZXJnZW50ZWNobm9sb2dpZXMuY29t
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAquGupqH3rJ8d9TPN4Rzp
ccFpZE8j0xzmq6i1ju2RwvL1BLODY2AVl9bxdgUVt1iIq0oZH0IBW/7zOQjaqS2Z
ar93M9tTPKXLAUxMR+ndUckkY7REwsAIhOcXdwyqL4ACXpRD411X6pIpwwuFe4Z0
xRMQq6KMZoJWLyBn6EXu9SmYLjupHPXD1n3HCY/4WzkXaYWVbQyH8NEOnAwRckms
OSwif+/miFepe8IyKRDx3jk9iktJV8lzpgNz/4fncJQE+tMcHPLoVetw2AOh3Xvt
5ziASVesr2oIRUG99kMCyQ/v9Cb911UmUJwVZyNV4cD/TmyudUgtHqeRmdPeDJT7
YwIDAQABo4IDczCCA28wDgYDVR0PAQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCB
gzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNl
cnQvYWxwaGFzc2xjYXNoYTI1Nmc0LmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29j
c3AuZ2xvYmFsc2lnbi5jb20vYWxwaGFzc2xjYXNoYTI1Nmc0MFcGA1UdIARQME4w
CAYGZ4EMAQIBMEIGCisGAQQBoDIKAQMwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBBBgNVHR8E
OjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2FscGhhc3NsY2Fz
aGEyNTZnNC5jcmwwQQYDVR0RBDowOIIbKi5jb252ZXJnZW50ZWNobm9sb2dpZXMu
Y29tghljb252ZXJnZW50ZWNobm9sb2dpZXMuY29tMB0GA1UdJQQWMBQGCCsGAQUF
BwMBBggrBgEFBQcDAjAfBgNVHSMEGDAWgBRPy6yowu+r3YNva7/OmD1cWCV2FTAd
BgNVHQ4EFgQUhsnbel4uPUvikLdKBcm7YtCjqg4wggF8BgorBgEEAdZ5AgQCBIIB
bASCAWgBZgB2AHPZnokbTJZ4oCB9R53mssYc0FFecRkqjGuAEHrBd3K1AAABhu5Z
zVwAAAQDAEcwRQIgdtEjXDzcomcNEdC3oGsVkfkDcXVv8je587qHNHb/LUMCIQDK
EGWBLpYA7DnKdi9JmbyJjRuOvuZ6UFbdfssFbfVCKAB1AO7N0GTV2xrOxVy3nbTN
E6Iyh0Z8vOzew1FIWUZxH7WbAAABhu5ZzTIAAAQDAEYwRAIgImtR4x5UKdJyAYKn
AXBquJ4ePyZxrWIYxCW/zrPT1c8CIGIUZOhyLVF7MI2qcPZmwwlhw4Yke0PA7wND
K9xYNyknAHUA2ra/az+1tiKfm8K7XGvocJFxbLtRhIU0vaQ9MEjX+6sAAAGG7lnN
cwAABAMARjBEAiBVc8XHqQvroqIhVpFWTJ1hnNxPJLpJvMFu9l1Kwp+cwAIgUCvv
dJeUNcP4eQrHq1pR/6iulLl7ZdWcKc1VQztpml4wDQYJKoZIhvcNAQELBQADggEB
AINSGohDdnybykqFInfG2TQ5SrAPfImooYbYkwm+GEgItvJ++3lcuuww0HdmB3Zf
/nlkAx+4GNcenhyWRnxRFftJG3MrNQ7mmRdiqcjbwE0H4kVf+iBJseAvxlc+rfl/
VeKfKAG2eJdYf27Oe+gt8lGG5rA76WYqZGvnM8DKrUFsZNNekOTMNPqDsALsUzZY
tSb8TH2K1IK7MR1trukjhPRgdRROWaC+MoK8f2Kx0kLi+wmSnSC31grzMIL6zfsT
E29Y4X3sArE7UK7WW0+RppsoSLR3e21U3xjfFbjSsG7PjmF9oT9MRyXHM+cB7t2y
4tCUvrLHTb77X2IJpye+83c=
-----END CERTIFICATE-----

EOF

cat <<EOF > /etc/apache2/ssl/cts-2023.key

-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCq4a6mofesnx31
M83hHOlxwWlkTyPTHOarqLWO7ZHC8vUEs4NjYBWX1vF2BRW3WIirShkfQgFb/vM5
CNqpLZlqv3cz21M8pcsBTExH6d1RySRjtETCwAiE5xd3DKovgAJelEPjXVfqkinD
C4V7hnTFExCrooxmglYvIGfoRe71KZguO6kc9cPWfccJj/hbORdphZVtDIfw0Q6c
DBFySaw5LCJ/7+aIV6l7wjIpEPHeOT2KS0lXyXOmA3P/h+dwlAT60xwc8uhV63DY
A6Hde+3nOIBJV6yvaghFQb32QwLJD+/0Jv3XVSZQnBVnI1XhwP9ObK51SC0ep5GZ
094MlPtjAgMBAAECggEAMJDHlHA/9f2bBA9fGfWfm0b+7xVW9y8ll+/w+dgnLyLh
5B4o31t1h5v9MC+txlgRL611il62CDFjavhLPP3Ktn4IIOLau0fbdFj87QtYbWAf
SX74c+kkArGzB5C/5ZQaGEtHKB1lWTOFTvu9Sigik8ghWsZt5MxyNh6dqXQGwAJF
WzjUQcjxz48r87voZW8M6NDskQn8k9Di+vGa6SI2BFoTt4+a/51RhZvNXhnxNP8C
+jQmGaYErR+obFLxEUHjYadrvuK/E+NDer0bSd1S84AtEDqrxNRIgqb1IwRiMRlT
fzkoi5TQNjDrXV36GXOxWSY8L8YI/yOcNbSswC47wQKBgQDYYZcgA2hCm/eyKPLg
3ogjHaQM4VwRjEcjlBkvH4VGzLEJRC103HQS+9g4WYN080n22sUsinetilFFfkpx
c3r2BQ8ozb9aOw4/XyeXY2J3e8UWhE7AJ811NRmF14w3Q+j1VJun4QhsOcoC9Sra
TWcolZvZ1xZAtKODgCahVuopcQKBgQDKK2STurqCSzIcbJ1BQEd58nacnNyrT4uA
YM+XRQj2zW5s6cxcE4Qh4YHdFi4VxKPnM5cms15i+BgIWeKlu76j3wyHOHYwB91k
9TybhSs8hIhE5u6I+TF2Bb8NIN1fRxcHClr8nU0IOZr9xRrSucsGdTMqdtshwMne
940m3z5oEwKBgGTyyp2d2VNSDnIo1n8AcsTnPDTiIqDxL/MyUbmBXB1Wu7VWAFsH
yoNcyVgossKqCjTHhbus8f6djCL+s15QgOosHBFuQ7ql2JTKIN9o93RE4wMJQPA2
4Yyv9DNUB091OEbUbTYaL2LGZy+QD6j++YSen7I2vWP8olhkPiGBOgeRAoGABm6M
+5o0NtL3nCnkct/9piaNmXvwFU8pjAMId7KNj3SHr9VcWA2S5ZUMEaGUA8NGx6M/
is6oERP9h758VHN9pC8DcgXc1LhbVcvrirMY5gr9XtvN+POcnDmgk2VZRZ+4XtP4
gxLqEXnrsWkk6lFY4TK3VwGDBTbh9UMA7ZyqmpsCgYEAxRxmOrJ37/raze2r5lHH
bu0Pu8OKVKLR7taDyEP7aNc22zCrgCcTkNiCGt0nd4ie6ucZcjNRL7fqBCC0zIpL
9HydTmn8mX2m1OBYPk5loe8Sqjc6fujUmeNFYSfhF+7XWb5e5bI5u1BkhfmKlfkD
h/gXbsUAiEg3EDMS794Zjyo=
-----END PRIVATE KEY-----

EOF

sudo bash

cat <<EOF > /etc/apache2/sites-enabled/default-ssl.conf

<IfModule mod_ssl.c>
<VirtualHost _default_:443>
ServerName k8s-ibp-admin.convergentechnologies.com


        ProxyPass  /gateway/ http://localhost:30004/
        ProxyPassReverse /gateway/ http://localhost:30004/

        ProxyPass  / http://localhost:30000/
        ProxyPassReverse / http://localhost:30000/
        Redirect / https://k8s-ibp-admin.convergentechnologies.com/

               SSLEngine on
               SSLCertificateFile /etc/apache2/ssl/cts-2023.crt
               SSLCertificateChainFile /etc/apache2/ssl/cts-2023-ca.crt
               SSLCertificateKeyFile /etc/apache2/ssl/cts-2023.key
</VirtualHost>

<VirtualHost _default_:443>
ServerName k8s-ibp-b2b.convergentechnologies.com


        ProxyPass  /gateway/ http://localhost:30004/
        ProxyPassReverse /gateway/ http://localhost:30004/

        ProxyPass  / http://localhost:30001/
        ProxyPassReverse / http://localhost:30001/
        Redirect / https://k8s-ibp-b2b.convergentechnologies.com/

               SSLEngine on
               SSLCertificateFile /etc/apache2/ssl/cts-2023.crt
               SSLCertificateChainFile /etc/apache2/ssl/cts-2023-ca.crt
               SSLCertificateKeyFile /etc/apache2/ssl/cts-2023.key
</VirtualHost>

</IfModule>


EOF

mkdir -p /data/logs/ibp-logs

sudo hostnamectl set-hostname  app-server

PUBLIC_IP=$(curl -s ifconfig.me)

PAYLOAD_ADMIN='[{"data":"'$PUBLIC_IP'","name":"'"k8s-ibp-admin"'","ttl":600,"type":"A"}]'

PAYLOAD_B2B='[{"data":"'$PUBLIC_IP'","name":"'"k8s-ibp-B2B"'","ttl":600,"type":"A"}]'

#admin-domain
# Send API Request
curl -X PATCH "https://api.godaddy.com/v1/domains/convergentechnologies.com/records" \
     -H "Authorization: sso-key AEayipWvcxU_BP4oXU2FDx337T1cEM7qAm:Mx7pYRUhGkqgAuihXiwbL" \
     -H "Content-Type: application/json" \
     --data "$PAYLOAD_ADMIN"
#b2b-domain
curl -X PATCH "https://api.godaddy.com/v1/domains/convergentechnologies.com/records" \
     -H "Authorization: sso-key AEayipWvcxU_BP4oXU2FDx337T1cEM7qAm:Mx7pYRUhGkqgAuihXiwbL" \
     -H "Content-Type: application/json" \
     --data "$PAYLOAD_B2B"

