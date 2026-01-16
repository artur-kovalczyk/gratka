defmodule UsersApi.ImportService do
  alias UsersApi.Accounts

  def import do
    name_male = load("names_male.txt")
    name_female = load("names_female.txt")
    male_surnames = load("surnames_male.txt")
    female_surnames = load("surnames_female.txt")

    Enum.each(1..100, fn _ ->
      gender = Enum.random(["male", "female"])
      first = if gender == "male", do: Enum.random(name_male), else: Enum.random(name_female)
      lastname = if gender == "male", do: Enum.random(male_surnames), else: Enum.random(female_surnames)
      Accounts.create_user(%{
        first_name: first,
        last_name: lastname,
        gender: gender,
        birthdate: random_date(~D[1970-01-01], ~D[2024-12-31])
      })
    end)
  end

  defp load(file) do
    Path.join(:code.priv_dir(:users_api), "data/#{file}")
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp random_date(from, to) do
    days = Date.diff(to, from)
    Date.add(from, Enum.random(0..days))
  end
end
