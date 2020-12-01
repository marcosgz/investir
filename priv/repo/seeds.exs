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

{:ok, %{body: %{"results" => overview_results}}} =
  Investir.Services.HgBrasil.get("/finance")

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
  end) |> Enum.filter(fn val -> val != nil end)

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
|> Investir.Repo.insert!
