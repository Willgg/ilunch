class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :new, :update]

  before_action :set_order, only: [:index, :show, :new, :update]
  before_action :set_line_item, only: [:new]

  after_action :verify_authorized, except: [:index, :show, :new, :update, :all_pdf]
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @orders = Order.where(user: current_user).order(id: :desc).done
  end

  def show
    if authorize(@order, @order.id, :show?)
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "facture-commande-#{@order.id}",
                 layout: 'layouts/pdf',
                 template: 'orders/show.pdf.erb',
                 title: "Facture ilunch n°#{@order.id}"
        end
      end
    else
      redirect_to menus_path
    end
  end

  def new
    @menus = policy_scope(Menu).where(active: true)
    @products = Product.category(params[:step])
    @products = @products.of_the_day(@order.date) if params[:step] == 'main'
    @menu_item = MenuItem.new
  end

  def update
    if authorize(current_user, @order, session[:order_id])
      if @order.update(order_params)
        respond_to do |format|
          format.html { redirect_to new_order_payment_path(@order)}
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to new_order_payment_path(@order)}
          format.js
        end
      end
    else
      redirect_to menus_path
    end
  end

  def all_pdf
    @orders = Order.done
    respond_to do |format|
      format.html
      format.pdf do
        @pdf = render_to_string pdf: "factures-ilunch",
                                layout: 'layouts/pdf',
                                template: 'orders/all.pdf.erb',
                                title: "Factures ilunch"
        send_data @pdf, 
                  filename: "factures-ilunch.pdf",
                  type: "application/pdf"
      end
    end
  end

  private

  def set_order
    if params[:id]
      @order = Order.find(params[:id])
    else
      super
      update_order(attributes) if @order.present? && attributes.present?
      create_order(attributes) if @order.nil?
    end
  end

  def set_line_item
    @line_item =
      if params[:step] == 'extra' || params[:step] == 'menu'
        LineItem.new
      elsif params[:line_item].present?
        LineItem.find(params[:line_item])
      else
        @order.line_items.select{ |li| li.is_a_menu? && li.incomplete? }.first
      end
  end

  def attributes
    a = {}
    a = a.merge( user: current_user ) if current_user
    a = a.merge( date: Date.parse(params[:date]) ) if params[:date]
    return a
  end

  def order_params
    params.require(:order).permit(:company_id)
  end

  def authorize(record, id, method)
    OrderPolicy.new(current_user, record, id).send(method.to_sym)
  end
end
