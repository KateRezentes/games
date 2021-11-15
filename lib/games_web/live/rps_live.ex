defmodule GamesWeb.RpsLive do
  use GamesWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        computer_choice: rand_rpc(),
        user_score: 0,
        computer_score: 0,
        message: "Best Out of Three",
        status: false
      )
    }
  end

  def rand_rpc() do
    number = :rand.uniform(3)
  end

  def pick(arg) do
    rps = Enum.at(["Rock", "Paper", "Scissors"], arg - 1)
  end

  def render(assigns) do
    ~L"""
    <h1>ROCK! PAPER! SCISSORS! SHOOOOOOTT!!!</h1>
    <p> <%= @message%> </p>
    <h2>You: <%= @user_score%> </h2>
    <h2>Computer: <%= @computer_score %></h2>
    <h1>Rock. Paper. Scissors. Shoot... </h1>
      <h2>
        <%= if @status do %>
          <a href="#" phx-click="reset" phx-value-choice=<%= 4 %>>Restart</a>
        <% else %>
        <%= for n <- 1..3 do %>
          <a href="#" phx-click="guess" phx-value-choice=<%= n %>><%= pick(n) %></a>
        <% end %>
        <% end %>
      </h2>
    """
  end

  def check(a, a), do: 0
  def check(1, 3), do: 1
  def check(2, 1), do: 1
  def check(3, 2), do: 1
  def check(_, _), do: -1

  def result(1, 1, b) do
    {"Congradulations! You win.", 2, b, rand_rpc(), true}
  end

  def result(1, a, b) do
    {"Again", a + 1, b, rand_rpc(), false}
  end

  def result(-1, a, 1) do
    {"Ha! Suck it. You Looooooose!", a, 2, rand_rpc(), true}
  end

  def result(-1, a, b) do
    {"Again!", a, b + 1, rand_rpc(), false}
  end

  def result(0, a, b) do
    {"Tie", a, b, rand_rpc(), false}
  end

  # Normy
  def handle_event(
        "guess",
        %{"choice" => guess} = data,
        %{
          assigns: %{
            computer_choice: choice,
            user_score: user_score,
            computer_score: computer_score
          }
        } = socket
      ) do
    check = check(String.to_integer(guess), choice)
    result = result(check, user_score, computer_score)

    message = "#{elem(result, 0)} #{pick(choice)}"

    {
      :noreply,
      assign(
        socket,
        message: message,
        computer_choice: elem(result, 3),
        user_score: elem(result, 1),
        computer_score: elem(result, 2),
        status: elem(result, 4)
      )
    }
  end

  # Restart
  # Normy
  def handle_event("reset", %{"choice" => reset} = data, socket) do
    {
      :noreply,
      assign(
        socket,
        message: "Best out of three",
        computer_choice: rand_rpc(),
        user_score: 0,
        computer_score: 0,
        status: false
      )
    }
  end
end
