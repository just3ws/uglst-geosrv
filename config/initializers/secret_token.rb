# Be sure to restart your server when you modify this file.

# Used to verify signed cookies and other encrypted data.
UglstGeosrv::Application.config.secret_key_base = ENV.fetch(
  'SECRET_KEY_BASE',
  'f109b64e20356ad1d32eae4c4958661f4d773883da96fd9077fd39f6a797277596c871876c0b915518e122f7207a7c5f6577b4e053c603277b62239e25a61d71'
)
