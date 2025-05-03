(
  echo "Host *"
  echo "    User ubuntu"
  echo "    IdentitiesOnly yes"
  echo "    PreferredAuthentications publickey"
  for key in ~/.ssh/id_rsa_*; do
    [[ -f "$key" && "$key" != *.pub ]] && echo "    IdentityFile $key"
  done
) > ./prod-ssh-config
