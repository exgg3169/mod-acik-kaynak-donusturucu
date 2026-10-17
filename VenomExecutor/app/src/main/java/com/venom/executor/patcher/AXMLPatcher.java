package com.venom.executor.patcher;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;

public class AXMLPatcher {

    private static final int RES_XML_TYPE             = 0x0003;
    private static final int RES_STRING_POOL_TYPE     = 0x0001;
    private static final int UTF8_FLAG                = 0x00000100;

    public static byte[] patchApplicationName(byte[] axmlBytes, String newClassName) throws IOException {
        ByteBuffer buf = ByteBuffer.wrap(axmlBytes).order(ByteOrder.LITTLE_ENDIAN);

        int fileType   = buf.getShort(0) & 0xFFFF;
        int fileHdrSz  = buf.getShort(2) & 0xFFFF;
        if (fileType != RES_XML_TYPE) throw new IOException("Not a binary XML file");

        buf.position(fileHdrSz);

        while (buf.remaining() >= 8) {
            int chunkStart = buf.position();
            int chunkType  = buf.getShort() & 0xFFFF;
            int hdrSize    = buf.getShort() & 0xFFFF;
            int chunkSize  = buf.getInt();

            if (chunkType == RES_STRING_POOL_TYPE) {
                int stringCount  = buf.getInt(chunkStart + 8);
                int styleCount   = buf.getInt(chunkStart + 12);
                int flags        = buf.getInt(chunkStart + 16);
                int stringsStart = buf.getInt(chunkStart + 20);
                boolean isUtf8   = (flags & UTF8_FLAG) != 0;

                int offsetsBase  = chunkStart + hdrSize;
                int strDataBase  = chunkStart + stringsStart;

                for (int i = 0; i < stringCount; i++) {
                    int offset = buf.getInt(offsetsBase + i * 4);
                    int strPos = strDataBase + offset;

                    String s = readString(buf, strPos, isUtf8);
                    if (s != null && looksLikeAppClass(s)) {
                        replaceString(buf, strPos, isUtf8, s, newClassName);
                    }
                }
                buf.position(chunkStart + chunkSize);
                continue;
            }
            if (chunkSize <= 0 || chunkSize > buf.capacity()) break;
            buf.position(chunkStart + chunkSize);
        }

        return axmlBytes;
    }

    private static boolean looksLikeAppClass(String s) {
        if (!s.contains(".")) return false;
        if (s.length() < 5) return false;
        if (s.contains("/")) return false;
        if (!Character.isLetter(s.charAt(0))) return false;
        String lo = s.toLowerCase();
        return lo.contains("application") || lo.contains("app") || lo.contains("main")
            || lo.contains("sandboxol") || lo.contains("blockyman");
    }

    private static String readString(ByteBuffer buf, int pos, boolean utf8) {
        try {
            if (utf8) {
                int utf16Len = readUtf8Len(buf, pos);
                int lenBytes1 = (buf.get(pos) & 0xFF) > 0x7F ? 2 : 1;
                int utf8Len  = readUtf8Len(buf, pos + lenBytes1);
                int lenBytes2 = (buf.get(pos + lenBytes1) & 0xFF) > 0x7F ? 2 : 1;
                int dataPos  = pos + lenBytes1 + lenBytes2;
                byte[] chars = new byte[utf8Len];
                for (int i = 0; i < utf8Len; i++) chars[i] = buf.get(dataPos + i);
                return new String(chars, StandardCharsets.UTF_8);
            } else {
                int charCount = buf.getShort(pos) & 0xFFFF;
                byte[] chars = new byte[charCount * 2];
                for (int i = 0; i < charCount * 2; i++) chars[i] = buf.get(pos + 2 + i);
                return new String(chars, StandardCharsets.UTF_16LE);
            }
        } catch (Exception e) {
            return null;
        }
    }

    private static int readUtf8Len(ByteBuffer buf, int pos) {
        int b = buf.get(pos) & 0xFF;
        if ((b & 0x80) != 0) {
            return ((b & 0x7F) << 8) | (buf.get(pos + 1) & 0xFF);
        }
        return b;
    }

    private static void replaceString(ByteBuffer buf, int pos, boolean utf8, String original, String replacement) {
        if (utf8) {
            byte[] origBytes = original.getBytes(StandardCharsets.UTF_8);
            byte[] newBytes  = replacement.getBytes(StandardCharsets.UTF_8);
            int lenBytes1 = (buf.get(pos) & 0xFF) > 0x7F ? 2 : 1;
            int lenBytes2 = (buf.get(pos + lenBytes1) & 0xFF) > 0x7F ? 2 : 1;
            int dataPos = pos + lenBytes1 + lenBytes2;

            int capacity = origBytes.length;
            if (newBytes.length > capacity) return;

            writeUtf8Len(buf, pos, replacement.length());
            writeUtf8Len(buf, pos + lenBytes1, newBytes.length);
            for (int i = 0; i < capacity; i++) {
                buf.put(dataPos + i, i < newBytes.length ? newBytes[i] : (byte) 0);
            }
        } else {
            byte[] origBytes = original.getBytes(StandardCharsets.UTF_16LE);
            byte[] newBytes  = replacement.getBytes(StandardCharsets.UTF_16LE);
            int charCount = original.length();
            int newCharCount = replacement.length();
            int dataPos = pos + 2;

            if (newBytes.length > origBytes.length) return;

            buf.putShort(pos, (short) newCharCount);
            for (int i = 0; i < origBytes.length; i++) {
                buf.put(dataPos + i, i < newBytes.length ? newBytes[i] : (byte) 0);
            }
        }
    }

    private static void writeUtf8Len(ByteBuffer buf, int pos, int len) {
        if ((buf.get(pos) & 0x80) != 0) {
            buf.put(pos,     (byte) ((len >> 8) | 0x80));
            buf.put(pos + 1, (byte) (len & 0xFF));
        } else {
            buf.put(pos, (byte) len);
        }
    }
}
