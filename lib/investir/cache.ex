defmodule Investir.Cache do
  use Nebulex.Cache,
    otp_app: :inform_api,
    adapter: Nebulex.Adapters.Local
end
