echo "[cata] v. 1.0b - github.com/disketteomelette \nUsage: sh cata.sh 12345678A1234B1234CD";
curl -s "https://www1.sedecatastro.gob.es/CYCBienInmueble/SECImprimirDatos.aspx?RefC=$1&del=41&mun=56&UrbRus=U" | html2text --body-width=1000 | sed '/^\s*$/d' | sed -n '/Fecha y hora/,//p' | tail -n +2 > buffer
fecha=$(grep -A 1 "Fecha" buffer | awk 'NR==2');
hora=$(grep -A 1 "Hora" buffer | awk 'NR==2');
ref=$(grep -A 1 "Referencia" buffer | awk 'NR==2');
loc=$(grep -A 3 "Localización" buffer | sed -n '/Localización/,/Superficie/p' | head -3 | grep -v "Localización" | tr '\n' ' ');
cla=$(grep -A 1 "Clase" buffer | awk 'NR==2');
uso=$(grep -A 1 "Uso" buffer | awk 'NR==2');
ph=$(grep "horizontal");
construccion=$(cat buffer | sed -n '/CONSTRUCCIÓN/,//p' | sed -n "/---/,//p");
sup=$(grep -A 1 "Superficie" buffer | awk 'NR==2');
echo "$ref [ $fecha $hora ]";
echo "$loc"
echo "$cla $uso - $ph"
echo "Superficie de $sup";
echo $construccion
rm buffer
