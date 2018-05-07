class TicketOrder < Order

  def generate_order_no
    "TK#{SecureRandom.hex(8)}"
  end
end