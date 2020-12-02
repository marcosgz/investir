defmodule Investir.Services.Fundamentus do
  @moduledoc """
  HTTP client to make requests with hgbrasil.com's REST API
  """

  alias Investir.Client.HTTP
  alias Finch.Response

  def pool_size, do: 10

  def child_spec() do
    config = Application.get_env(:investir, __MODULE__)
    HTTP.init(config, __MODULE__, pool_size())
  end

  # /resultado.php
  def post(path, body \\ %{}) do
    form_data = URI.encode_query(body)
    IO.inspect(form_data)

    :post
    |> HTTP.request(path, query: %{}, headers: headers(), body: form_data)
  end

  defp headers do
    [
      {"User-Agent", "Mozilla/5.0"},
      {"Origin", "https://fundamentus.com.br"},
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Accept", "text/html,application/xhtml+xml,application/xml"},
      {"Referer", "https://fundamentus.com.br/buscaavancada.php"}
    ]
  end
end

# curl 'https://fundamentus.com.br/resultado.php' \
#   -H 'Connection: keep-alive' \
#   -H 'Pragma: no-cache' \
#   -H 'Cache-Control: no-cache' \
#   -H 'Upgrade-Insecure-Requests: 1' \
#   -H 'Origin: https://fundamentus.com.br' \
#   -H 'Content-Type: application/x-www-form-urlencoded' \
#   -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36' \
#   -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
#   -H 'Sec-Fetch-Site: same-origin' \
#   -H 'Sec-Fetch-Mode: navigate' \
#   -H 'Sec-Fetch-User: ?1' \
#   -H 'Sec-Fetch-Dest: document' \
#   -H 'Referer: https://fundamentus.com.br/buscaavancada.php' \
#   -H 'Accept-Language: en-US,en;q=0.9' \
#   -H 'Cookie: __utmz=138951332.1604452126.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); _fbp=fb.2.1604452125720.573204570; __gads=ID=58ccc2c6f2d63e73-22b33fd8c0b3007c:T=1604452126:RT=1604452126:S=ALNI_MZibPyK4Aa_2FQmFy_9OTsEAGgN0g; PHPSESSID=baa2a7d562d628d9299e834ce913ceec; __utma=138951332.1598429830.1604452126.1604452126.1606867928.2; __utmc=138951332; __utmt=1; __utmb=138951332.5.10.1606867928' \
#   --data-raw 'pl_min=&pl_max=&pvp_min=&pvp_max=&psr_min=&psr_max=&divy_min=&divy_max=&pativos_min=&pativos_max=&pcapgiro_min=&pcapgiro_max=&pebit_min=&pebit_max=&fgrah_min=&fgrah_max=&firma_ebit_min=&firma_ebit_max=&firma_ebitda_min=&firma_ebitda_max=&margemebit_min=&margemebit_max=&margemliq_min=&margemliq_max=&liqcorr_min=&liqcorr_max=&roic_min=&roic_max=&roe_min=&roe_max=&liq_min=&liq_max=&patrim_min=&patrim_max=&divbruta_min=&divbruta_max=&tx_cresc_rec_min=&tx_cresc_rec_max=&setor=&negociada=ON&ordem=1&x=47&y=29' \
#   --compressed
