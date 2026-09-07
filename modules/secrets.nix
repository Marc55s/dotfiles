let
   admin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmMEHJkey2YR4q7pgJVcgq8mi3Wfu2rJnwnQiMAoLjW marc@pc";
   monolith = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDAG03ajGpK6Nln4fR9iVzftBlfyYAovyrxmEvCmazXW";

in
{
  "ionos-ddns-url.age".publicKeys = [
    admin
    monolith
  ];
}
