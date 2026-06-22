extends RefCounted
class_name BuildFlags

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13.1-DevFlags
# ------------------------------------------------------------

# ------------------------------------------------------------
# FLAGS DE BUILD / TEST
# Modifier ces constantes avant export selon le type de build.
# ------------------------------------------------------------

# true  = outil de téléportation disponible pour test local.
# false = outil de téléportation masqué et bloqué pour build playtest/exécutable.
const DEV_TELEPORT_ENABLED: bool = false
