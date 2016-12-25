defmodule BigSnips.Repo do
  use Ecto.Repo, otp_app: :big_snips
  use Scrivener, page_size: 6
end
