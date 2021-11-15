defmodule Games.Repo.Migrations.CreateRpss do
  use Ecto.Migration

  def change do
    create table(:rpss) do
      add :user_score, :integer
      add :computer_score, :integer
      add :message, :string
      add :rand_number, :integer

      timestamps()
    end
  end
end
