for configuration in ./configure/*.sh; do
  echo "Configure: $configuration"
  source $configuration
done