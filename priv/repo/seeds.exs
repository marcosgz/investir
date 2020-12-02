# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Investir.Repo.insert!(%Investir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Investir.Finance.Overview

# overview_results = %{
#   "available_sources" => ["BRL"],
#   "bitcoin" => %{
#     "bitstamp" => %{
#       "buy" => 18957.59,
#       "format" => ["USD", "en_US"],
#       "last" => 18960.2,
#       "name" => "BitStamp",
#       "sell" => 18950.0,
#       "variation" => -2.469
#     },
#     "blockchain_info" => %{
#       "buy" => 18968.47,
#       "format" => ["USD", "en_US"],
#       "last" => 18968.47,
#       "name" => "Blockchain.info",
#       "sell" => 18968.47,
#       "variation" => -2.503
#     },
#     "coinbase" => %{
#       "format" => ["USD", "en_US"],
#       "last" => 18918.53,
#       "name" => "Coinbase",
#       "variation" => -2.787
#     },
#     "foxbit" => %{
#       "format" => ["BRL", "pt_BR"],
#       "last" => 99873.67,
#       "name" => "FoxBit",
#       "variation" => -4.055
#     },
#     "mercadobitcoin" => %{
#       "buy" => 99823.32109,
#       "format" => ["BRL", "pt_BR"],
#       "last" => 100_329.31,
#       "name" => "Mercado Bitcoin",
#       "sell" => 100_329.28645,
#       "variation" => -3.502
#     }
#   },
#   "currencies" => %{
#     "ARS" => %{
#       "buy" => 0.0649,
#       "name" => "Argentine Peso",
#       "sell" => nil,
#       "variation" => -1.113
#     },
#     "AUD" => %{
#       "buy" => 3.8688,
#       "name" => "Australian Dollar",
#       "sell" => nil,
#       "variation" => -1.646
#     },
#     "BTC" => %{
#       "buy" => 105_703.634,
#       "name" => "Bitcoin",
#       "sell" => 105_703.634,
#       "variation" => -2.464
#     },
#     "CAD" => %{
#       "buy" => 4.0568,
#       "name" => "Canadian Dollar",
#       "sell" => nil,
#       "variation" => -1.664
#     },
#     "CNY" => %{
#       "buy" => 0.7992,
#       "name" => "Renminbi",
#       "sell" => nil,
#       "variation" => -1.884
#     },
#     "EUR" => %{
#       "buy" => 6.333,
#       "name" => "Euro",
#       "sell" => 6.3315,
#       "variation" => -0.85
#     },
#     "GBP" => %{
#       "buy" => 7.0547,
#       "name" => "Pound Sterling",
#       "sell" => nil,
#       "variation" => -0.917
#     },
#     "JPY" => %{
#       "buy" => 0.0503,
#       "name" => "Japanese Yen",
#       "sell" => nil,
#       "variation" => -1.864
#     },
#     "USD" => %{
#       "buy" => 5.2551,
#       "name" => "Dollar",
#       "sell" => 5.255,
#       "variation" => -1.704
#     },
#     "source" => "BRL"
#   },
#   "stocks" => %{
#     "CAC" => %{
#       "location" => "Paris, French",
#       "name" => "CAC 40",
#       "variation" => 63.09
#     },
#     "IBOVESPA" => %{
#       "location" => "Sao Paulo, Brazil",
#       "name" => "BM&F BOVESPA",
#       "points" => 111_290.852,
#       "variation" => 2.2
#     },
#     "NASDAQ" => %{
#       "location" => "New York City, United States",
#       "name" => "NASDAQ Stock Market",
#       "points" => 12385.31,
#       "variation" => 1.53
#     },
#     "NIKKEI" => %{
#       "location" => "Tokyo, Japan",
#       "name" => "Nikkei 225",
#       "variation" => 1.34
#     }
#   },
#   "taxes" => [
#     %{
#       "cdi" => 2.0,
#       "cdi_daily" => 1.9,
#       "daily_factor" => 1.00007469,
#       "date" => "2020-11-30",
#       "selic" => 2.0,
#       "selic_daily" => 1.9
#     }
#   ]
# }

{:ok, %{body: %{"results" => overview_results}}} = Investir.Services.HgBrasil.get("/finance")

stocks =
  Enum.map(Map.get(overview_results, "stocks"), fn {code, entry} ->
    %Overview.Stock{code: code} |> Overview.Stock.changeset(entry)
  end)

currencies =
  Enum.map(Map.get(overview_results, "currencies"), fn {code, entry} ->
    case entry do
      %{} -> %Overview.Currency{code: code} |> Overview.Currency.changeset(entry)
      _ -> nil
    end
  end)
  |> Enum.filter(fn val -> val != nil end)

bitcoins =
  Enum.map(Map.get(overview_results, "bitcoin"), fn {code, entry} ->
    %Overview.Bitcoin{code: code} |> Overview.Bitcoin.changeset(entry)
  end)

%Overview{
  available_sources: overview_results["available_sources"],
  taxes: overview_results["taxes"],
  stocks: stocks,
  currencies: currencies,
  bitcoins: bitcoins
}
|> Investir.Repo.insert!()


body = %{
  pl_min: nil,
  pl_max: nil,
  pvp_min: nil,
  pvp_max: nil,
  psr_min: nil,
  psr_max: nil,
  divy_min: nil,
  divy_max: nil,
  pativos_min: nil,
  pativos_max: nil,
  pcapgiro_min: nil,
  pcapgiro_max: nil,
  pebit_min: nil,
  pebit_max: nil,
  fgrah_min: nil,
  fgrah_max: nil,
  firma_ebit_min: 0,
  firma_ebit_max: nil,
  firma_ebitda_min: 0,
  firma_ebitda_max: nil,
  margemebit_min: nil,
  margemebit_max: nil,
  margemliq_min: nil,
  margemliq_max: nil,
  liqcorr_min: nil,
  liqcorr_max: nil,
  roic_min: nil,
  roic_max: nil,
  roe_min: nil,
  roe_max: nil,
  liq_min: 200000,
  liq_max: nil,
  patrim_min: nil,
  patrim_max: nil,
  divbruta_min: nil,
  divbruta_max: nil,
  tx_cresc_rec_min: nil,
  tx_cresc_rec_max: nil,
  setor: nil,
  negociada: "ON",
  ordem: "9",
  x: "25",
  y: "14"
}

url = "https://fundamentus.com.br/resultado.php"
headers = [
  {"User-Agent", "Mozilla/5.0"},
  {"Origin", "https://fundamentus.com.br"},
  {"Content-Type", "application/x-www-form-urlencoded"},
  {"Accept", "text/html,application/xhtml+xml,application/xml"},
  {"Referer", "https://fundamentus.com.br/buscaavancada.php"}
]

{:ok, response} = Finch.build(:post, url, headers, URI.encode_query(body)) |> Finch.request(Investir.Services.HgBrasil)
{:ok, html} = Floki.parse_document(response.body)


Enum.each(Floki.find(html, "#resultado tbody tr"), fn row ->
  {_tr, _props, cols} = row

  values = row |> Floki.find("td") |> Enum.map(&Floki.text(&1))

  # td1 - Papel
  # td2 - Cotacao
  # td11 - EB/EBI
  # td14 - Margem liquida
  # td19 - Patrimonio liquido
  # td21 - crescimento
  org = %Investir.DeepValueInvesting.Organization{} |>
    Investir.DeepValueInvesting.Organization.changeset(
      %{
        code: Enum.at(values, 0),
        quotation: Enum.at(values, 1) |> String.replace(",", "."),
        ev_ebi: Enum.at(values, 10) |> String.replace(",", "."),
        net_margin: Enum.at(values, 13) |> String.replace(~r{[^,\d]+}, "") |> String.replace(",", "."),
        net_worth: Enum.at(values, 18) |> String.replace(~r{[^,\d]+}, "") |> String.replace(",", "."),
        variation: Enum.at(values, 20) |> String.replace(~r{[^,\d]+}, "") |> String.replace(",", "."),
      }
    )
    |> Investir.Repo.insert!
end)
