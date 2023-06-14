rc4() {
  local data="$1"
  local key="$2"
  local data_len="${#data}"
  local key_len="${#key}"

  local s i j a b c temp

  for i in $(seq 0 255); do
    s[i]=$i
  done

  j=0
  for i in $(seq 0 255); do
    j=$(( (j + s[i] + $(printf '%d' "'${key:i % key_len:1}")) % 256 ))
    temp=${s[i]}
    s[i]=${s[j]}
    s[j]=$temp
  done

  a=0
  b=0
  encrypted_data=""
  for i in $(seq 0 $((data_len - 1))); do
    a=$(( (a + 1) % 256 ))
    b=$(( (b + s[a]) % 256 ))
    temp=${s[a]}
    s[a]=${s[b]}
    s[b]=$temp
    c=$(( (s[a] + s[b]) % 256 ))
    encrypted_byte=$(( ${s[c]} ^ $(printf '%d' "'${data:i:1}") ))
    encrypted_data=$(printf "%s%02x" "$encrypted_data" $encrypted_byte)
  done
  echo "$encrypted_data"
}

rckey=$(date +%s%3N)
user="your_account_number_here"
password="your_password_number_here"
encrypted_password=$(rc4 "$password" "$rckey")
while true
do 
    ping -c 3 www.baidu.com > /dev/null 2>&1
    if [ $? -eq 0 ];then
    echo "network ok"
    else
    echo "no network"
		curl 'http://1.1.1.3/ac_portal/login.php' \
		  -H 'Connection: keep-alive' \
		  -H 'Accept: */*' \
		  -H 'X-Requested-With: XMLHttpRequest' \
		  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36 Edg/111.0.1661.44' \
		  -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
		  -H 'Origin: http://1.1.1.3' \
		  -H 'Referer: http://1.1.1.3/ac_portal/20230318032256/pc.html?template=20230318032256&tabs=pwd-sms&vlanid=0&_ID_=0&switch_url=&url=http://1.1.1.3/homepage/index.html&controller_type=&mac=99-99-99-99-99-99' \
		  -H 'Accept-Language: zh-CN,zh;q=0.9' \
		  -H 'Accept-Encoding: gzip, deflate' \
		  --data "opr=pwdLogin&userName=$user&pwd=$encrypted_password&auth_tag=$rckey&rememberPwd=0" \
		  && logger "Web authentication authenticated"
		  fi
    exit 0
done