defmodule Games.ShortgamesTest do
  use Games.DataCase

  alias Games.Shortgames

  describe "rpss" do
    alias Games.Shortgames.Rps

    import Games.ShortgamesFixtures

    @invalid_attrs %{computer_score: nil, message: nil, rand_number: nil, user_score: nil}

    test "list_rpss/0 returns all rpss" do
      rps = rps_fixture()
      assert Shortgames.list_rpss() == [rps]
    end

    test "get_rps!/1 returns the rps with given id" do
      rps = rps_fixture()
      assert Shortgames.get_rps!(rps.id) == rps
    end

    test "create_rps/1 with valid data creates a rps" do
      valid_attrs = %{computer_score: 42, message: "some message", rand_number: 42, user_score: 42}

      assert {:ok, %Rps{} = rps} = Shortgames.create_rps(valid_attrs)
      assert rps.computer_score == 42
      assert rps.message == "some message"
      assert rps.rand_number == 42
      assert rps.user_score == 42
    end

    test "create_rps/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shortgames.create_rps(@invalid_attrs)
    end

    test "update_rps/2 with valid data updates the rps" do
      rps = rps_fixture()
      update_attrs = %{computer_score: 43, message: "some updated message", rand_number: 43, user_score: 43}

      assert {:ok, %Rps{} = rps} = Shortgames.update_rps(rps, update_attrs)
      assert rps.computer_score == 43
      assert rps.message == "some updated message"
      assert rps.rand_number == 43
      assert rps.user_score == 43
    end

    test "update_rps/2 with invalid data returns error changeset" do
      rps = rps_fixture()
      assert {:error, %Ecto.Changeset{}} = Shortgames.update_rps(rps, @invalid_attrs)
      assert rps == Shortgames.get_rps!(rps.id)
    end

    test "delete_rps/1 deletes the rps" do
      rps = rps_fixture()
      assert {:ok, %Rps{}} = Shortgames.delete_rps(rps)
      assert_raise Ecto.NoResultsError, fn -> Shortgames.get_rps!(rps.id) end
    end

    test "change_rps/1 returns a rps changeset" do
      rps = rps_fixture()
      assert %Ecto.Changeset{} = Shortgames.change_rps(rps)
    end
  end
end
