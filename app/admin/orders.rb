ActiveAdmin.register Order do
  permit_params :total_price, :state, :address_id, :user_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :state, as: :select, collection: [Order::NEW,
                                                Order::PROCESSING,
                                                Order::SHIPPED,
                                                Order::DELIVERED,
                                                Order::CANCELLED]
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
