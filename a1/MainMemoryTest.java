package arch.sm213.machine.student;
import machine.AbstractMainMemory;
import org.junit.Before;
import org.junit.Test;
import static junit.framework.TestCase.assertEquals;


public class MainMemoryTest {
    private MainMemory m;

    @Before
    public void init(){
        m = new MainMemory(32);
    }
    @Test
    public void testAlignment(){
        assertEquals(false, m.isAccessAligned(1234, 67));
        assertEquals(true, m.isAccessAligned(2, 2));
    }
    @Test
    public void testBytesToInteger(){
        assertEquals(0x00000000, m.bytesToInteger((byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00));
        assertEquals(0xff000000, m.bytesToInteger((byte) 0xff, (byte) 0x00, (byte) 0x00, (byte) 0x00));
        assertEquals(0xf0000080, m.bytesToInteger((byte) 0xf0, (byte) 0x00, (byte) 0x00, (byte) 0x80));
    }
    @Test
    public void testIntegerToBytes()
    {
        byte mem[] = new byte[4];
        mem[0] = (byte) 0x01;
        mem[1] = (byte) 0x02;
        mem[2] = (byte) 0x03;
        mem[3] = (byte) 0x04;
        assertEquals(mem, m.integerToBytes(0x01020304));
    }

    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testSetException() throws AbstractMainMemory.InvalidAddressException {
        MainMemory m1 = new MainMemory(8);
        byte mem[] = new byte[4];
        mem[0] = (byte) 0x01;
        mem[1] = (byte) 0x02;
        mem[2] = (byte) 0x03;
        mem[3] = (byte) 0x04;

        m1.set(0x0257, mem);
    }

    @Test (expected = AbstractMainMemory.InvalidAddressException.class)
    public void testGetException() throws AbstractMainMemory.InvalidAddressException {
        MainMemory m1 = new MainMemory(8);
        m1.get(257, 4);
    }

    @Test
    public void testGet()
    {
        MainMemory m1 = new MainMemory(32);
        byte mem[] = new byte[4];
        mem[0] = (byte) 0x20;
        mem[1] = (byte) 0x21;
        mem[2] = (byte) 0x22;
        mem[3] = (byte) 0x23;

        try {
            assertEquals(mem, m1.get(20, 4));
        } catch (AbstractMainMemory.InvalidAddressException e) {
            System.out.println("Exception should not have been thrown!\n");
        }
    }

    @Test
    public void testSet()
    {

    }
}
