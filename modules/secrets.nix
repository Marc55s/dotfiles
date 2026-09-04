let
   admin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmMEHJkey2YR4q7pgJVcgq8mi3Wfu2rJnwnQiMAoLjW marc@pc";
   monolith = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINd3fYoWvCv2hrkjtOj9uYZgb0l9y//1Vsa8LEd+8qbc";
in
{
  "ionos-ddns-url.age".publicKeys = [
    admin
    monolith
  ];
}
