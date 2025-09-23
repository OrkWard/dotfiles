# asdf
export ASDF_CONFIG_FILE="$HOME/.config/asdf/asdfrc"
export ASDF_DATA_DIR="$HOME/.local/state/asdf"
prepand_path "${ASDF_DATA_DIR}/shims"

# dotnet
asdf_update_dotnet_home() {
  if command -v asdf &> /dev/null; then
    dotnet_path="$(asdf which dotnet)"
  fi

  local dotnet_path
  dotnet_path="$(asdf which dotnet)"
  if [[ -n "${dotnet_path}" ]]; then
    export DOTNET_ROOT
    DOTNET_ROOT="$(dirname "$(realpath "${dotnet_path}")")"
    export MSBuildSDKsPath
    DOTNET_VERSION="$(dotnet --version)"
    export MSBuildSDKsPath="$DOTNET_ROOT/sdk/$DOTNET_VERSION/Sdks"
    export DOTNET_CLI_TELEMETRY_OPTOUT=1
  fi
}
preexec_functions+=(asdf_update_dotnet_home)
