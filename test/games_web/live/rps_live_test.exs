defmodule GamesWeb.RpsLiveTest do
  use GamesWeb.ConnCase

  import Phoenix.LiveViewTest
  import Games.ShortgamesFixtures

  @create_attrs %{computer_score: 42, message: "some message", rand_number: 42, user_score: 42}
  @update_attrs %{computer_score: 43, message: "some updated message", rand_number: 43, user_score: 43}
  @invalid_attrs %{computer_score: nil, message: nil, rand_number: nil, user_score: nil}

  defp create_rps(_) do
    rps = rps_fixture()
    %{rps: rps}
  end

  describe "Index" do
    setup [:create_rps]

    test "lists all rpss", %{conn: conn, rps: rps} do
      {:ok, _index_live, html} = live(conn, Routes.rps_index_path(conn, :index))

      assert html =~ "Listing Rpss"
      assert html =~ rps.message
    end

    test "saves new rps", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.rps_index_path(conn, :index))

      assert index_live |> element("a", "New Rps") |> render_click() =~
               "New Rps"

      assert_patch(index_live, Routes.rps_index_path(conn, :new))

      assert index_live
             |> form("#rps-form", rps: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rps-form", rps: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rps_index_path(conn, :index))

      assert html =~ "Rps created successfully"
      assert html =~ "some message"
    end

    test "updates rps in listing", %{conn: conn, rps: rps} do
      {:ok, index_live, _html} = live(conn, Routes.rps_index_path(conn, :index))

      assert index_live |> element("#rps-#{rps.id} a", "Edit") |> render_click() =~
               "Edit Rps"

      assert_patch(index_live, Routes.rps_index_path(conn, :edit, rps))

      assert index_live
             |> form("#rps-form", rps: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#rps-form", rps: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rps_index_path(conn, :index))

      assert html =~ "Rps updated successfully"
      assert html =~ "some updated message"
    end

    test "deletes rps in listing", %{conn: conn, rps: rps} do
      {:ok, index_live, _html} = live(conn, Routes.rps_index_path(conn, :index))

      assert index_live |> element("#rps-#{rps.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#rps-#{rps.id}")
    end
  end

  describe "Show" do
    setup [:create_rps]

    test "displays rps", %{conn: conn, rps: rps} do
      {:ok, _show_live, html} = live(conn, Routes.rps_show_path(conn, :show, rps))

      assert html =~ "Show Rps"
      assert html =~ rps.message
    end

    test "updates rps within modal", %{conn: conn, rps: rps} do
      {:ok, show_live, _html} = live(conn, Routes.rps_show_path(conn, :show, rps))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Rps"

      assert_patch(show_live, Routes.rps_show_path(conn, :edit, rps))

      assert show_live
             |> form("#rps-form", rps: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#rps-form", rps: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.rps_show_path(conn, :show, rps))

      assert html =~ "Rps updated successfully"
      assert html =~ "some updated message"
    end
  end
end
