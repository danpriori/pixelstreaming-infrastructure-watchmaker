choco install openssl

$certPath = ".\certificates"
mkdir -Force $certPath

# generate certificates
openssl req -x509 -newkey rsa:4096 -keyout $certPath\client-key.pem -out $certPath\client-cert.pem -nodes -days 365 -subj "/C=NO/ST=Oslo/L=Oslo/O=Auth/OU=3D/CN=watchmaker"
