package logic;

import java.awt.Desktop;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import com.itextpdf.io.font.FontConstants;
import com.itextpdf.io.font.constants.StandardFonts;
import com.itextpdf.io.image.ImageDataFactory;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.events.Event;
import com.itextpdf.kernel.events.IEventHandler;
import com.itextpdf.kernel.events.PdfDocumentEvent;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfPage;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Canvas;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.Border;
import com.itextpdf.layout.borders.SolidBorder;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Image;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;
import com.itextpdf.layout.property.UnitValue;

import entities.Presupuesto;
import entities.Producto;


public class PresupuestoPDF {
	
	public static void main(String[] args) throws IOException, FileNotFoundException{
	}
		
		public void crear(Presupuesto pres) throws IOException, FileNotFoundException{
		System.out.println("Entra pdf");	
		System.out.println("Entra pdf");	
		System.out.println("Entra pdf");	
		System.out.println("Entra pdf");	
		System.out.println("Entra pdf");	

		FileOutputStream fos = new FileOutputStream("f:\\7IMG.pdf");
		PdfWriter writer = new PdfWriter(fos);
		PdfDocument pdf = new PdfDocument(writer);
		Document doc = new Document(pdf);
		doc.setMargins(5, 5, 22, 15); //Top Right Bottom Left

		pdf.addEventHandler(PdfDocumentEvent.END_PAGE, new TextFooterEventHandler(doc));

//		Image titulo = new Image(ImageDataFactory.create("src/TabaqueriaChaya.jpg"));
//		doc.add(titulo);
//		
		
		
		
		
		//Comprador

		Paragraph comprador = new Paragraph();
		comprador.add("Cuit/Cuil: ");
		comprador.add(pres.getCuit());
		comprador.add("\tNombre: ");
		comprador.add(pres.getNombre());
		comprador.add("\tTelefono: ");
		comprador.add(pres.getTelefono());
		comprador.add("\tMail: ");
		comprador.add(pres.getMail());
		comprador.add("\nDireccion: ");
		comprador.add(pres.getDireccion());
		comprador.add("\tLocalidad: ");
		comprador.add(pres.getLocalidad() + ", " + pres.getCodigoPostal());
		comprador.add("\tProvincia: ");
		comprador.add(pres.getProvincia());
		comprador.add("\t\t");
		comprador.add(String.valueOf(java.time.LocalDate.now()));
		doc.add(comprador.setBorder(new SolidBorder(1)));
		
		float[] columnWidths = {5, 2, 15,10,5};
        Table table = new Table(UnitValue.createPercentArray(columnWidths)).useAllAvailableWidth();
        table.setMarginTop(10);
        table.setMarginBottom(10);

        //Header
        PdfFont fontH = PdfFontFactory.createFont(FontConstants.HELVETICA_BOLD);
        Cell id = new Cell().add(new Paragraph("Id ")).setFont(fontH).setBackgroundColor(new DeviceRgb(169,169,169));
        Cell cantidad = new Cell().add(new Paragraph("Cantidad ")).setFont(fontH).setBackgroundColor(new DeviceRgb(169,169,169));
        Cell descripcion = new Cell().add(new Paragraph("Descripcion ")).setFont(fontH).setBackgroundColor(new DeviceRgb(169,169,169));
        Cell precioU = new Cell().add(new Paragraph("Precio x U ")).setFont(fontH).setBackgroundColor(new DeviceRgb(169,169,169));
        Cell subtotal = new Cell().add(new Paragraph("Subtotal ")).setFont(fontH).setBackgroundColor(new DeviceRgb(169,169,169));

        table.addCell(id).setTextAlignment(TextAlignment.CENTER);
        table.addCell(cantidad);
        table.addCell(descripcion);
        table.addCell(precioU);
        table.addCell(subtotal);
        //Body
        
        for(Producto p: pres.getProds()) {
           	table.addCell(p.getId()).setBorder(Border.NO_BORDER);
 	        table.addCell(String.valueOf(p.getCant())).setBorder(Border.NO_BORDER);
 	        table.addCell(p.getNombre()).setBorder(Border.NO_BORDER);
 	        table.addCell(String.valueOf(p.getPrecio())).setBorder(Border.NO_BORDER);
 	        table.addCell(String.valueOf(p.getPrecio()*p.getCant())).setBorder(Border.NO_BORDER);
        	
        }
//        for(int i=0;i<155;i++) {
//        	table.addCell(i+"abc").setBorder(Border.NO_BORDER);
// 	        table.addCell("abc").setBorder(Border.NO_BORDER);
// 	        table.addCell("abc").setBorder(Border.NO_BORDER);
// 	        table.addCell("abc").setBorder(Border.NO_BORDER);
// 	        table.addCell("abc").setBorder(Border.NO_BORDER);
//        }
        doc.add(table);
      
        Paragraph footer = new Paragraph("Subtotal $\n Descuento $\n Total $");


        
        doc.add(footer.setTextAlignment(TextAlignment.RIGHT).setBorder(new SolidBorder(1)));

		doc.close();

		File file = new File("F:\\\\7IMG.pdf");
		Desktop desktop = Desktop.getDesktop();
	    desktop.open(file);
	      

}

 private static class TextFooterEventHandler  implements IEventHandler {
        protected Document doc;
        protected String actual;
       // protected String total;
        public TextFooterEventHandler(Document doc) {
            this.doc = doc;
   
        }

        public void handleEvent(Event currentEvent) {
            PdfDocumentEvent docEvent = (PdfDocumentEvent) currentEvent;
            Rectangle pageSize = docEvent.getPage().getPageSize();
            PdfFont font = null;
            PdfPage page = docEvent.getPage();
            
            
            this.actual= String.valueOf(docEvent.getDocument().getPageNumber(page));
            //this.total= String.valueOf(docEvent.getDocument().getNumberOfPages());
            try {
                font = PdfFontFactory.createFont(StandardFonts.HELVETICA_OBLIQUE);
            } catch (IOException e) {

                // Such an exception isn't expected to occur,
                // because helvetica is one of standard fonts
                System.err.println(e.getMessage());
            }

            float coordX = ((pageSize.getLeft() + doc.getLeftMargin())
                    + (pageSize.getRight() - doc.getRightMargin())) / 2;
            //float headerY = pageSize.getTop() - doc.getTopMargin() + 10;
            float footerY = (float) (doc.getBottomMargin()*0.7);
            
            Canvas canvas = new Canvas(docEvent.getPage(), pageSize);
            canvas
            

                    // If the exception has been thrown, the font variable is not initialized.
                    // Therefore null will be set and iText will use the default font - Helvetica
                    .setFont(font)
                    .setFontSize(12)
                    .showTextAligned("Pagina "+actual , coordX, footerY, TextAlignment.CENTER)
                    .close();
      }
   }

}
